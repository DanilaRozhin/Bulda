extends Control

@onready var settings = $CanvasLayer
@onready var musicBar = $"CanvasLayer/Settings/MarginsMusic&Sounds/Music&Sounds/Music/MusicBar"
@onready var soundsBar = $"CanvasLayer/Settings/MarginsMusic&Sounds/Music&Sounds/Sounds/SoundsBar"



func _ready():
	if "Player" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	elif "MainMenu" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_INHERIT
	
	musicBar.value = GlobalSettings.volumeMusic
	soundsBar.value = GlobalSettings.volumeSounds
	show_settings()



func show_settings() -> void:
	settings.show()


func hide_settings() -> void:
	GlobalSettings.save_data()
	
	if "Player" in str(get_parent()):
		get_parent().get_node("Stats").show_stats()
		get_parent().get_node("Interface").show_interface()
		get_tree().paused = false
	
	elif "MainMenu" in str(get_parent()):
		get_parent().show_buttons()
	
	queue_free()


func update_volume_sounds() -> void:
	soundsBar.value = GlobalSettings.volumeSounds
	
	if "Player" in str(get_parent()):
		get_parent().update_volume_sounds()


func update_volume_music() -> void:
	musicBar.value = GlobalSettings.volumeMusic
	
	if "Player" in str(get_parent()):
		get_parent().get_parent().update_volume_music()
	
	elif "MainMenu" in str(get_parent()):
		get_parent().update_volume_music()



func _on_plus_sounds_pressed():
	if GlobalSettings.volumeSounds >= 0:
		return
	
	GlobalSettings.volumeSounds += 2
	update_volume_sounds()


func _on_minus_sounds_pressed():
	if GlobalSettings.volumeSounds <= -60:
		return
	
	GlobalSettings.volumeSounds -= 2
	update_volume_sounds()


func _on_plus_music_pressed():
	if GlobalSettings.volumeMusic >= 0:
		return
	
	GlobalSettings.volumeMusic += 2
	update_volume_music()


func _on_minus_music_pressed():
	if GlobalSettings.volumeMusic <= -60:
		return
	
	GlobalSettings.volumeMusic -= 2
	update_volume_music()


func _on_close_pressed():
	hide_settings()
