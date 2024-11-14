extends Control

@onready var header = $CanvasLayer/PrologueBox/Margins/Prologue/Header
@onready var text = $CanvasLayer/PrologueBox/Margins/Prologue/Text
@onready var prologueBox = $CanvasLayer/PrologueBox

@onready var soundTextPrinting = $TextPrinting

var prologue
var prologuePath = ""
var textNum = 0

var textFinished = false



func _ready():
	prologueBox.show()
	soundTextPrinting.volume_db = GlobalSettings.volumeSounds
	start_prologue("res://ScenesANDScripts/Levels/Prologue/Prologue1.json")



func start_prologue(path) -> void:
	textNum = 0
	prologuePath = path
	prologue = get_prologue()
	next_phrase()


func get_prologue() -> Array:
	var file = FileAccess.open(prologuePath, FileAccess.READ)
	var json = file.get_as_text()
	var output = JSON.parse_string(json)
	file.close()
	return output


func next_phrase() -> void:
	if textNum >= len(prologue):
		get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/Level1/Parts/Part1/LoadingScreenPart1.tscn")
		return
	
	textFinished = false
	soundTextPrinting.play()
	
	header.text = prologue[textNum]["Header"]
	text.bbcode_text = prologue[textNum]["Text"]
	
	text.visible_characters = 0
	
	var textPrintingSpeed = Timer.new()
	textPrintingSpeed.wait_time = 0.05
	textPrintingSpeed.one_shot = true
	add_child(textPrintingSpeed)
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		textPrintingSpeed.start()
		await textPrintingSpeed.timeout
	
	textNum += 1
	soundTextPrinting.stop()
	textPrintingSpeed.queue_free()
	textFinished = true



func _on_next_pressed():
	if textFinished:
		next_phrase()
		return
	
	text.visible_characters = len(text.text)
	soundTextPrinting.stop()
