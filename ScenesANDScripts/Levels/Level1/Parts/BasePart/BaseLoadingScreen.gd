extends Control 
class_name BaseLoadingScreen

@export var pathLevel = ""
@export var numberLevel = 0
@export var numberPart = 0



func _ready():
	GlobalLevel.currentLevel = pathLevel
	
	if GlobalLevel.maxPart >= numberPart and GlobalLevel.maxLevel >= numberLevel:
		return
	
	GlobalLevel.maxPart = numberPart
	GlobalLevel.maxLevel = numberLevel
	GlobalLevel.save_data()



func _on_next_pressed():
	get_tree().change_scene_to_file(pathLevel)
