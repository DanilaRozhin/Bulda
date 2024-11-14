extends Node2D


@onready var sprite = $Sprite
@onready var areaPickUP = $AreaPickUP
@onready var soundPickUP = $PickUP

@export var increaseHP = 10



func _ready():
	sprite.hide()



func _on_area_pick_up_body_entered(body):
	if "Player" in body.name:
		areaPickUP.set_deferred("monitoring", false)
		sprite.hide()
		
		body.add_hp(increaseHP)
		
		soundPickUP.volume_db = GlobalSettings.volumeSounds
		soundPickUP.play()


func _on_pick_up_finished():
	queue_free()


func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
