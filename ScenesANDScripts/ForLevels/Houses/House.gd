extends StaticBody2D


@onready var sprite = $Sprite



func _ready():
	sprite.hide()



func _on_area_knock_door_body_entered(body):
	if "Player" in body.name:
		body.canKnockDoor = true
		body.show_button_action()


func _on_area_knock_door_body_exited(body):
	if "Player" in body.name:
		body.canKnockDoor = false
		body.hide_button_action()


func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
