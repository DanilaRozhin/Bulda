extends Control


@onready var interface = $CanvasLayer

@onready var buttonsControl = {
	"moveLeft" : $CanvasLayer/MoveButtons/MoveLeft,
	"moveRight" : $CanvasLayer/MoveButtons/MoveRight,
	"action" : $CanvasLayer/MoveButtons/Action,
	"jump" : $CanvasLayer/MoveButtons/Jump,
	"attack" : $CanvasLayer/MoveButtons/Attack
}

@onready var buttonsMenu = {
	"information" : $CanvasLayer/MarginsMenuButtons/MenuButtons/Information,
	"settings" : $CanvasLayer/MarginsMenuButtons/MenuButtons/Settings,
	"trade" : $CanvasLayer/MarginsMenuButtons/MenuButtons/Trade,
	"skillTree" : $CanvasLayer/MarginsMenuButtons/MenuButtons/SkillTree,
	"reloadScene" : $CanvasLayer/MarginsMenuButtons/MenuButtons/ReloadScene,
	"returnMainMenu" : $CanvasLayer/MarginsMenuButtons/MenuButtons/ReturnMenu
}



func _ready():
	position_control_buttons()



func position_control_buttons() -> void:
	var screenSize = get_viewport_rect().size
	
	buttonsControl["moveLeft"].position.x = 100
	buttonsControl["moveLeft"].position.y = screenSize.y - 180
	
	buttonsControl["moveRight"].position.x = 325
	buttonsControl["moveRight"].position.y = screenSize.y - 180
	
	buttonsControl["action"].position.x = screenSize.x - 575
	buttonsControl["action"].position.y = screenSize.y - 180
		
	buttonsControl["jump"].position.x = screenSize.x - 425
	buttonsControl["jump"].position.y = screenSize.y - 180
	
	buttonsControl["attack"].position.x = screenSize.x - 225
	buttonsControl["attack"].position.y = screenSize.y - 180


func show_interface() -> void:
	interface.show()


func hide_interface() -> void:
	interface.hide()


func add_children(scene) -> void:
	hide_interface()
	
	if not "Player" in str(get_parent()):
		return
	
	get_parent().get_node("Stats").hide_stats()
	get_tree().paused = true
	var children = scene.instantiate()
	get_parent().call_deferred("add_child", children)


func keyboard() -> void:
	if Input.is_action_just_pressed("up"): buttonsControl["jump"].emit_signal("pressed")
	
	if Input.is_action_just_released("up"): buttonsControl["jump"].emit_signal("released")
	
	if Input.is_action_just_pressed("attack"): buttonsControl["attack"].emit_signal("pressed")
	
	if Input.is_action_just_released("attack"): buttonsControl["attack"].emit_signal("released")
	
	if Input.is_action_pressed("right"): buttonsControl["moveRight"].emit_signal("pressed")
	
	if Input.is_action_just_released("right"): buttonsControl["moveRight"].emit_signal("released")
	
	if Input.is_action_pressed("left"): buttonsControl["moveLeft"].emit_signal("pressed")
	
	if Input.is_action_just_released("left"): buttonsControl["moveLeft"].emit_signal("released")
	
	if Input.is_action_just_pressed("action"): buttonsControl["action"].emit_signal("pressed")
	
	if Input.is_action_just_released("action"): buttonsControl["action"].emit_signal("released")



func _process(_delta):
	keyboard()



func _on_move_left_pressed(): GlobalInput.moveLeft = true


func _on_move_left_released(): GlobalInput.moveLeft = false


func _on_move_right_pressed(): GlobalInput.moveRight = true


func _on_move_right_released(): GlobalInput.moveRight = false


func _on_action_pressed(): GlobalInput.action = true


func _on_action_released(): GlobalInput.action = false


func _on_jump_pressed(): GlobalInput.jump = true


func _on_jump_released(): GlobalInput.jump = false


func _on_attack_pressed(): GlobalInput.attack = true


func _on_attack_released(): GlobalInput.attack = false


func _on_menu_pressed():
	for button in buttonsMenu:
		buttonsMenu[button].visible = not buttonsMenu[button].visible


func _on_return_menu_pressed(): get_tree().change_scene_to_file("res://ScenesANDScripts/MainMenu/MainMenu.tscn")


func _on_reload_scene_pressed(): get_tree().reload_current_scene()


func _on_skill_tree_pressed():
	GlobalInput.reset()

	var skillTree = load("res://ScenesANDScripts/ForPlayer/SkillTree/SkillTree.tscn")
	add_children(skillTree)


func _on_trade_pressed():
	GlobalInput.reset()
	
	var tradeScreen = load("res://ScenesANDScripts/Characters/Sellers/TradeScreen/TradeScreen.tscn")
	add_children(tradeScreen)


func _on_settings_pressed():
	GlobalInput.reset()
	
	var settings = load("res://ScenesANDScripts/Settings/Settings.tscn")
	add_children(settings)


func _on_information_pressed():
	GlobalInput.reset()
	
	var buttonsControls = load("res://ScenesANDScripts/ButtonsControl/ButtonsControl.tscn")
	add_children(buttonsControls)
