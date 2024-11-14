extends Node2D
class_name BasePart


@export var cameraLimit = 0

@onready var player #инициализация в дочернем классе

@onready var musicStart = $Start
@onready var musicLoop = $Loop

var numberSilverCoins = 0
var numberGoldCoins = 0
var numberKeys = 0

var numberKeysFromGlobal = GlobalPlayer.numberKeys


func _ready():
	update_volume_music()
	player.camera.limit_right = cameraLimit


func update_volume_music() -> void:
	musicStart.volume_db = GlobalSettings.volumeMusic
	musicLoop.volume_db = GlobalSettings.volumeMusic


func update_global() -> void:
	GlobalPlayer.numberSilverCoins += numberSilverCoins
	GlobalPlayer.numberGoldCoins += numberGoldCoins
	GlobalPlayer.numberKeys = numberKeysFromGlobal
	GlobalPlayer.numberKeys += numberKeys


func add_key(numKeys) -> void:
	numberKeys += numKeys


func add_silver_coin(numSilverCoins) -> void:
	numberSilverCoins += numSilverCoins


func add_gold_coin(numGoldCoins) -> void:
	numberGoldCoins += numGoldCoins


func remove_key(numKeys) -> void:
	numberKeysFromGlobal -= numKeys


func next_part(pathNextPart) -> void:
	update_global()
	GlobalPlayer.save_data()
	get_tree().change_scene_to_file.bind(pathNextPart).call_deferred()



func _on_start_finished():
	musicLoop.play()
