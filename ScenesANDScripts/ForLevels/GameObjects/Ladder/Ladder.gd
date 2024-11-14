extends Node2D


@onready var sprite = $Sprite



func _ready():
	sprite.hide()



func _on_area_lift_body_entered(body):
	if "Player" in body.name:
		body.canLift = true
		body.show_button_action()


func _on_area_lift_body_exited(body):
	if "Player" in body.name:
		body.canLift = false
		body.hide_button_action()


func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
