extends Node


var volumeSounds = 0
var volumeMusic = 0

var savePath = "user://save_settings.dat"

var data = {
	"VolumeSounds" : "0",
	"VolumeMusic" : "0"
}



func save_data() -> void:
	data["VolumeSounds"] = str(volumeSounds)
	data["VolumeMusic"] = str(volumeMusic)

	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_line(JSON.stringify(data))


func load_data() -> void:
	if not FileAccess.file_exists(savePath):
		return
	
	var file = FileAccess.open(savePath, FileAccess.READ)
	data = JSON.parse_string(file.get_line())

	volumeSounds = int(data["VolumeSounds"])
	volumeMusic = int(data["VolumeMusic"])
