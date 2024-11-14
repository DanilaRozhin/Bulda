extends Node2D



func _on_area_border_body_entered(body):
	if "Enemy" in body.name or "CharacterBody2D" in body.name:
		body.change_direction()
