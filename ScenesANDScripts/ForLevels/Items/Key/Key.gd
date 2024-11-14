extends Node2D


@onready var sprite = $Sprite
@onready var areaPickUP = $AreaPickUP
@onready var soundPickUP = $PickUP



func _ready():
	sprite.hide()



func increase_number_keys(numberKeys) -> void:
	get_parent().get_parent().add_key(numberKeys)



func _on_area_pick_up_body_entered(body):
	if "Player" in body.name:
		areaPickUP.set_deferred("monitoring", false)
		sprite.hide()
		
		increase_number_keys(1)
		body.update_stats("Keys")
		
		soundPickUP.volume_db = GlobalSettings.volumeSounds
		soundPickUP.play()
	
		if GlobalLevel.dialogWithElfArcherCompleted == "true":
			body.set_information("Интересно, для чего он? Не об этом ли говорил Фьюст?")
		else:
			body.set_information("Это ключ... но от чего он? Пока не понятно")


func _on_pick_up_finished():
	queue_free()


func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
