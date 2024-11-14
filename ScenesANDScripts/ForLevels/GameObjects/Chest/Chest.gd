extends Node2D


@onready var animatedSprite = $AnimatedSprite
@onready var areaOpen = $AreaOpen
@onready var soundOpen = $Open



func _ready():
	animatedSprite.hide()



func spawn_gold_coin() -> void:
	var goldCoin = load("res://ScenesANDScripts/ForLevels/Items/Coins/Gold/GoldCoin.tscn").instantiate()
	goldCoin.position.x = position.x
	goldCoin.position.y = position.y - 25
	get_parent().call_deferred("add_child", goldCoin)



func _on_area_open_body_entered(body):
	if not "Player" in body.name:
		return
	
	if get_parent().get_parent().numberKeysFromGlobal <= 0:
		body.set_information("К сожалению, у меня нету ключа, чтобы открыть этот сундук")
		return
	
	areaOpen.set_deferred("monitoring", false)
	
	get_parent().get_parent().remove_key(1)
	body.update_stats("Global")
	
	animatedSprite.play("open")
	soundOpen.volume_db = GlobalSettings.volumeSounds
	soundOpen.play()


func _on_open_finished():
	queue_free()
	spawn_gold_coin()


func _on_visible_on_screen_enabler_screen_entered():
	animatedSprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	animatedSprite.hide()
