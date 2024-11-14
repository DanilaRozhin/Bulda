extends Node

var currentLevel

var dialogWithElfArcherCompleted = "false"
var maxLevel = 0
var maxPart = 0

var savePath = "user://save_level.dat"

var data = {
	"DialogWithElfArcherCompleted" : "false",
	"MaxPart" : "0",
	"MaxLevel" : "0"
}



func save_data() -> void:
	data["DialogWithElfArcherCompleted"] = str(dialogWithElfArcherCompleted)
	data["MaxLevel"] = str(maxLevel)
	data["MaxPart"] = str(maxPart)
	
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_line(JSON.stringify(data))


func load_data() -> void:
	if not FileAccess.file_exists(savePath):
		return
	
	var file = FileAccess.open(savePath, FileAccess.READ)
	data = JSON.parse_string(file.get_line())

	dialogWithElfArcherCompleted = str(data["DialogWithElfArcherCompleted"])
	maxLevel = int(data["MaxLevel"])
	maxPart = int(data["MaxPart"])
