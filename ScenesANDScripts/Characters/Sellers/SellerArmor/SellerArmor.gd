extends Node2D


@onready var animatedSprite = $AnimatedSprite
@onready var information = $Information
@onready var dialog = $Dialogue

var firstDialogFinished = false



func _ready():
	animatedSprite.hide()
	animatedSprite.play("sell")
	information.hide()



func start_dialog(dPath1, dPath2):
	if not dialog.dialogStarted and not firstDialogFinished:
		dialog.start_dialog(dPath1)
	
	elif not dialog.dialogStarted and firstDialogFinished:
		dialog.start_dialog(dPath2)
	
	elif dialog.dialogStarted:
		dialog.continue_dialog()


func stop_dialog():
	if dialog.dialogStarted:
		dialog.stop_dialog()
		return
	
	firstDialogFinished = true


func create_timer(waitTime) -> Timer:
	var timer = Timer.new()
	timer.wait_time = waitTime
	timer.one_shot = true
	add_child(timer)
	return timer


func set_information(info) -> void:
	information.text = info
	information.visible_characters = 0
	information.show()
	
	var timerInformationTextSpeed = create_timer(0.05)
	
	while(information.visible_characters < len(information.text)):
		information.visible_characters += 1
		timerInformationTextSpeed.start()
		await timerInformationTextSpeed.timeout
	
	timerInformationTextSpeed.queue_free()
	
	var timerInformation = create_timer(5)
	timerInformation.start()
	await timerInformation.timeout
	
	timerInformation.queue_free()
	information.hide()
	information.text = " "



func _on_visible_on_screen_enabler_screen_entered():
	animatedSprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	animatedSprite.hide()
