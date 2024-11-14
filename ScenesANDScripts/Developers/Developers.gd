extends Control

@onready var developers = $CanvasLayer



func _ready():
	if "MainMenu" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_INHERIT
	
	show_developers()



func show_developers() -> void:
	developers.show()


func hide_developers() -> void:
	if "MainMenu" in str(get_parent()):
		get_parent().show_buttons()

	queue_free()



func _on_close_pressed():
	hide_developers()
