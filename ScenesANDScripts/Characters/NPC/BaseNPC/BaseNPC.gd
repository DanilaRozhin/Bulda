extends CharacterBody2D
class_name BaseNPC


@onready var animation = $AnimationTree
@onready var information = $Information
@onready var sprite = $Sprite
@onready var dialog = $Dialogue

const GRAVITY = 600
const SPEED = 300

var firstDialogFinished = false


func _ready():
	sprite.hide()
	animation["parameters/conditions/idle"] = true
	animation["parameters/conditions/run"] = false
	information.hide()



func start_dialog(dPath1, dPath2) -> void:
	if not dialog.dialogStarted and not firstDialogFinished:
		dialog.start_dialog(dPath1)
	
	elif not dialog.dialogStarted and firstDialogFinished:
		dialog.start_dialog(dPath2)
	
	elif dialog.dialogStarted:
		dialog.continue_dialog()


func stop_dialog() -> void:
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


func die() -> void:
	animation["parameters/conditions/die"] = true



func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	set_velocity(velocity)
	set_up_direction(Vector2(0, -1))
	move_and_slide()
	velocity = velocity



func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
