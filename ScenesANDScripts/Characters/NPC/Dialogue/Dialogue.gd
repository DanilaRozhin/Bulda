extends Control


@onready var dialogName = $CanvasLayer/DialogueBox/Margins/Dialogue/MarginsName/Name
@onready var dialogText = $CanvasLayer/DialogueBox/Margins/Dialogue/Text
@onready var dialogBox = $CanvasLayer/DialogueBox

var dialog
var dialogPath = ""
var phraseNum = 0

var phraseFinished = false
var dialogStarted = false
var dialogStopped = false



func _ready():
	dialogBox.hide()



func start_dialog(dPath):
	dialogStarted = true
	phraseNum = 0
	dialogPath = dPath
	dialog = get_dialog()
	dialogBox.show()
	next_phrase()


func stop_dialog():
	dialogStopped = true
	dialogBox.hide()


func continue_dialog():
	dialogStopped = false
	dialogBox.show()


func get_dialog() -> Array:
	var file = FileAccess.open(dialogPath, FileAccess.READ)
	var json = file.get_as_text()
	var output = JSON.parse_string(json)
	file.close()
	return output


func next_phrase():
	if phraseNum >= len(dialog):
		dialogStarted = false
		dialogBox.hide()
		return

	phraseFinished = false

	dialogName.bbcode_text = dialog[phraseNum]["Name"]
	dialogText.bbcode_text = dialog[phraseNum]["Text"]

	dialogText.visible_characters = 0
	
	var timerTextSpeed = Timer.new()
	timerTextSpeed.wait_time = 0.05
	timerTextSpeed.one_shot = true
	add_child(timerTextSpeed)

	while dialogText.visible_characters < len(dialogText.text):
		dialogText.visible_characters += 1
		timerTextSpeed.start()
		await timerTextSpeed.timeout

	timerTextSpeed.queue_free()
	phraseNum += 1
	phraseFinished = true



func _process(_delta):
	if GlobalInput.action:
		if not dialogStopped and dialogStarted and phraseFinished:
			next_phrase()
			GlobalInput.action = false
		elif not dialogStopped and dialogStarted and not phraseFinished:
			dialogText.visible_characters = len(dialogText.text)
			GlobalInput.action = false
		
