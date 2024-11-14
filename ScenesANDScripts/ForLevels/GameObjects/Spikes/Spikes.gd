extends Node2D


@onready var areaDamage = $AreaDamage
@onready var sprite = $Sprite

@export var damage = 20



func _ready():
	sprite.hide()



func create_timer(waitTime) -> Timer:
	var timer = Timer.new()
	timer.wait_time = waitTime
	timer.one_shot = true
	return timer


func cooldown_area_damage() -> void:
		var timerCooldownAreaDamage = create_timer(2)
		add_child(timerCooldownAreaDamage)
		timerCooldownAreaDamage.start()
	
		await timerCooldownAreaDamage.timeout
		timerCooldownAreaDamage.queue_free()
		areaDamage.set_deferred("monitoring", true)



func _on_area_damage_body_entered(body):
	if "Player" in body.name:
		areaDamage.set_deferred("monitoring", false)
		body.take_damage(damage, self)
		cooldown_area_damage()


func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
