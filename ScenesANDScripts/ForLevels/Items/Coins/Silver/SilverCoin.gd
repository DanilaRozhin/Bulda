extends Node2D

@onready var animatedSprite = $AnimatedSprite
@onready var areaPickUP = $AreaPickUP
@onready var soundPickUP = $PickUP

@export var numberAddSilverCoins = 0



func _ready():
	animatedSprite.hide()
	animatedSprite.play("SilverCoin")



func increase_number_silver_coins(numberSilverCoins) -> void:
	get_parent().get_parent().add_silver_coin(numberSilverCoins)



func _on_area_pick_up_body_entered(body):
	if "Player" in body.name:
		areaPickUP.set_deferred("monitoring", false)
		animatedSprite.hide()
		
		increase_number_silver_coins(numberAddSilverCoins)
		body.update_stats("SilverCoins")
		
		soundPickUP.volume_db = GlobalSettings.volumeSounds
		soundPickUP.play()


func _on_pick_up_finished():
	queue_free()


func _on_visible_on_screen_enabler_screen_entered():
	animatedSprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	animatedSprite.hide()
