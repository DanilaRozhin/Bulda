extends Node


var numberSilverCoins = 0
var numberGoldCoins = 0
var numberKeys = 0

var numberGreenPoints = 0
var numberBluePoints = 0

var savePath = "user://save_player.dat"

var data = {
	"NumberSilverCoins" : "0",
	"NumberGoldCoins" : "0",
	"NumberKeys" : "0",
	"NumberGreenPoints" : "0",
	"NumberBluePoints" : "0"
}



func save_data() -> void:
	data["NumberSilverCoins"] = str(numberSilverCoins)
	data["NumberGoldCoins"] = str(numberGoldCoins)
	data["NumberKeys"] = str(numberKeys)
	data["NumberGreenPoints"] = str(numberGreenPoints)
	data["NumberBluePoints"] = str(numberBluePoints)
	
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_line(JSON.stringify(data))


func load_data() -> void:
	if not FileAccess.file_exists(savePath):
		return
	
	var file = FileAccess.open(savePath, FileAccess.READ)
	data = JSON.parse_string(file.get_line())

	numberSilverCoins = int(data["NumberSilverCoins"])
	numberGoldCoins = int(data["NumberGoldCoins"])
	numberKeys = int(data["NumberKeys"])
	numberGreenPoints = int(data["NumberGreenPoints"])
	numberBluePoints = int(data["NumberBluePoints"])
