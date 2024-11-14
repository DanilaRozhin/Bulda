extends BaseFarmLevel



func _ready():
	update_volume_music()
	initialization()
	super._ready()



func initialization() -> void:
	player = $PlayerKnight
	
	markers = {
		"1" : $Markers/Marker1,
		"2" : $Markers/Marker2,
		"3" : $Markers/Marker3,
		"4" : $Markers/Marker4,
		"5" : $Markers/Marker5,
		"6" : $Markers/Marker6,
		"7" : $Markers/Marker7
	}
	
	enemies = {
		"iceGolem" : load("res://ScenesANDScripts/Characters/Enemies/Melee/IceGolem/EnemyIceGolem.tscn"),
		"grassGolem" : load("res://ScenesANDScripts/Characters/Enemies/Melee/GrassGolem/EnemyGrassGolem.tscn"),
		"goblin" : load("res://ScenesANDScripts/Characters/Enemies/Melee/Goblin/EnemyGoblin.tscn")
	}
