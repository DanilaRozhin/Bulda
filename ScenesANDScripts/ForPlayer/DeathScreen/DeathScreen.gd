extends Control



func _on_restart_pressed():
	get_tree().change_scene_to_file(GlobalLevel.currentLevel)


func _on_back_menu_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/MainMenu/MainMenu.tscn")
