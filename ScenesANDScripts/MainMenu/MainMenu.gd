extends Control

@onready var buttons = $CanvasLayer
@onready var parallaxJungle = $CameraMenu/ParallaxBackground/ParallaxJungle
@onready var parallaxGround = $CameraMenu/ParallaxBackground/ParallaxGround
@onready var spriteParallaxJungle = $CameraMenu/ParallaxBackground/ParallaxJungle/Jungle
@onready var spriteParallaxGround = $CameraMenu/ParallaxBackground/ParallaxGround/Ground

@onready var sections = {
	"menu" : $CanvasLayer/Margins/Menu,
	"levels" : $CanvasLayer/Margins/Levels,
	"level1" : $CanvasLayer/Margins/Level1,
	"information" : $CanvasLayer/Margins/Information
}

@onready var buttonsLevels = {
	"level1" : $CanvasLayer/Margins/Levels/Level1
}

@onready var buttonsLevel1 = {
	"part1" : $CanvasLayer/Margins/Level1/Part1,
	"part2" : $CanvasLayer/Margins/Level1/Part2,
	"part3" : $CanvasLayer/Margins/Level1/Part3,
	"part4" : $CanvasLayer/Margins/Level1/Part4,
	"part5" : $CanvasLayer/Margins/Level1/FarmLevel
}

@onready var music = $Music



func _ready():
	GlobalPlayer.load_data()
	GlobalSettings.load_data()
	GlobalSkillTree.load_data()
	GlobalLevel.load_data()

	update_volume_music()
	#disable_levels()
	show_section("menu")
	
	if get_viewport_rect().size.y == 720:
		resize_background(0.7)
	
	if get_viewport_rect().size.y == 1440:
		resize_background(1.4)



func show_buttons() -> void:
	buttons.show()


func resize_background(scaleXY) -> void:
	spriteParallaxJungle.scale.x = scaleXY
	spriteParallaxJungle.scale.y = scaleXY
	parallaxJungle.motion_mirroring.x *= scaleXY
	
	spriteParallaxGround.scale.x = scaleXY
	spriteParallaxGround.scale.y = scaleXY
	parallaxGround.motion_mirroring.x *= scaleXY


func disable_buttons(listNameButtons, listButtons):
	for button in listButtons:
		if button in listNameButtons:
			listButtons[button].disabled = true



func disable_levels() -> void:
	if GlobalLevel.maxLevel == 0:
		disable_buttons(["level1"], buttonsLevels)
		return
	
	if GlobalLevel.maxPart == 0:
		disable_buttons(["part1", "part2", "part3", "part4", "part5"], buttonsLevel1)

	elif GlobalLevel.maxPart == 1:
		disable_buttons(["part2", "part3", "part4", "part5"], buttonsLevel1)

	elif GlobalLevel.maxPart == 2:
		disable_buttons(["part3", "part4", "part5"], buttonsLevel1)

	elif GlobalLevel.maxPart == 3:
		disable_buttons(["part4", "part5"], buttonsLevel1)
	
	elif GlobalLevel.maxPart == 4:
		disable_buttons(["part5"], buttonsLevel1)


func update_volume_music() -> void:
	music.volume_db = GlobalSettings.volumeMusic


func show_section(sectionName) -> void:
	for sect in sections:
		if sect == sectionName:
			sections[sect].show()
			continue
		
		sections[sect].hide()


func add_children(scene) -> void:
	buttons.hide()
	var children = scene.instantiate()
	call_deferred("add_child", children)



func _process(delta):
	parallaxJungle.motion_offset.x += 100 * delta
	parallaxGround.motion_offset.x += 100 * delta



func _on_play_pressed():
	show_section("levels")


func _on_prologue_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/Prologue/Prologue.tscn")


func _on_level_1_pressed():
	show_section("level1")


func _on_farm_level_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/FarmLevels/FarmLevel1/LoadingScreenFarmLevel1.tscn")


func _on_back_to_menu_pressed():
	show_section("menu")


func _on_part_1_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/Level1/Parts/Part1/LoadingScreenPart1.tscn")


func _on_part_2_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/Level1/Parts/Part2/LoadingScreenPart2.tscn")


func _on_part_3_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/Level1/Parts/Part3/LoadingScreenPart3.tscn")


func _on_part_4_pressed():
	get_tree().change_scene_to_file("res://ScenesANDScripts/Levels/Level1/Parts/Part4/LoadingScreenPart4.tscn")


func _on_back_to_levels_pressed():
	show_section("levels")


func _on_settings_pressed():
	var settings = load("res://ScenesANDScripts/Settings/Settings.tscn")
	add_children(settings)


func _on_information_pressed():
	show_section("information")


func _on_buttons_control_pressed():
	var buttonsControl = load("res://ScenesANDScripts/ButtonsControl/ButtonsControl.tscn")
	add_children(buttonsControl)


func _on_developers_pressed():
	var developers = load("res://ScenesANDScripts/Developers/Developers.tscn")
	add_children(developers)


func _on_exit_pressed():
	get_tree().quit()
