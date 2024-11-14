extends Control

@onready var header = $CanvasLayer/EpilogueBox/Margins/Epilogue/Header
@onready var text = $CanvasLayer/EpilogueBox/Margins/Epilogue/Text
@onready var epilogueBox = $CanvasLayer/EpilogueBox

@onready var soundTextPrinting = $TextPrinting

var epilogue
var epiloguePath = ""
var textNum = 0

var textFinished = false



func _ready():
	epilogueBox.show()
	soundTextPrinting.volume_db = GlobalSettings.volumeSounds
	start_epilogue("res://ScenesANDScripts/Levels/Epilogue/Epilogue.json")



func start_epilogue(path) -> void:
	textNum = 0
	epiloguePath = path
	epilogue = get_epilogue()
	next_phrase()


func get_epilogue() -> Array:
	var file = FileAccess.open(epiloguePath, FileAccess.READ)
	var textFromFile = file.get_as_text()
	var output = JSON.parse_string(textFromFile)
	file.close()
	return output


func next_phrase() -> void:
	if textNum >= len(epilogue):
		get_tree().change_scene_to_file("res://ScenesANDScripts/MainMenu/MainMenu.tscn")
		return
	
	textFinished = false
	soundTextPrinting.play()
	
	header.text = epilogue[textNum]["Header"]
	text.bbcode_text = epilogue[textNum]["Text"]

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
