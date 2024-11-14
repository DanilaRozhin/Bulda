extends Node2D


@onready var animatedSprite = $AnimatedSprite
@onready var areaPickUP = $AreaPickUP
@onready var soundPickUP = $PickUP



func _ready():
	animatedSprite.hide()
	animatedSprite.play("GoldCoin")



func increase_number_gold_coins(numberGoldCoins) -> void:
	get_parent().get_parent().add_gold_coin(numberGoldCoins)


func _on_area_pick_up_body_entered(body):
	if "Player" in body.name:
		areaPickUP.set_deferred("monitoring", false)
		animatedSprite.hide()
		
		increase_number_gold_coins(1)
		body.update_stats("GoldCoins")
		
		soundPickUP.volume_db = GlobalSettings.volumeSounds
		soundPickUP.play()


func _on_pick_up_finished():
	queue_free()


func _on_visible_on_screen_enabler_screen_entered():
	animatedSprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	animatedSprite.hide()
