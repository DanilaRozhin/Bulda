extends Control

@onready var buttonsControl = $CanvasLayer



func _ready():
	if "Player" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	elif "MainMenu" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_INHERIT
	
	show_buttons_control()



func show_buttons_control() -> void:
	buttonsControl.show()


func hide_buttons_control() -> void:
	if "Player" in str(get_parent()):
		get_parent().get_node("Stats").show_stats()
		get_parent().get_node("Interface").show_interface()
		get_tree().paused = false
	
	elif "MainMenu" in str(get_parent()):
		get_parent().show_buttons()
	
	queue_free()



func _on_close_pressed():
	hide_buttons_control()
