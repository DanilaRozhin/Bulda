extends CharacterBody2D
class_name BaseEnemy

const GRAVITY = 600

@export var hp = 100
@export var baseDamage = 100
@export var baseMoveSpeed = 100

@onready var collisions = {
	"main" : $Collision,
	"visibility" : $AreaVisibility/CollisionVisibility,
	"rangeAttack" : $AreaRangeAttack/CollisionRangeAttack,
	"attack" : $AreaAttack/CollisionAttack
}

@onready var areas = {
	"visibility" : $AreaVisibility,
	"rangeAttack" : $AreaRangeAttack,
	"attack" : $AreaAttack
}

@onready var sounds = {
	"hurt" : $Hurt,
	"hit" : $Hit
}

@onready var animationTree = $AnimationTree
@onready var sprite = $Sprite
@onready var hpBar = $HPBar

var states = {
	"alive" : true,
	"hurt" : false,
	"attack" : false,
	"jump" : false
}

var seePlayer = false
var direction = 1


func _ready():
	sprite.hide()
	
	hpBar.max_value = hp
	hpBar.value = hp
	
	update_volume_sounds()



func update_volume_sounds():
	for sound in sounds:
		sounds[sound].volume_db = GlobalSettings.volumeSounds


func create_timer(waitTime) -> Timer:
	var timer = Timer.new()
	timer.wait_time = waitTime
	timer.one_shot = true
	add_child(timer)
	return timer


func create_label(text, color) -> void:
	var label = Label.new()
	label.text = text
	label.set("theme_override_colors/font_color", color)
	label.set("theme_override_colors/font_shadow_color", Color(0, 0, 0, 1))
	label.set("theme_override_font_sizes/font_size", 20)
	label.position.x = 25
	label.position.y = 0
	add_child(label)
	
	var timer = create_timer(0.1)
	var alphaColor = 1
	
	while(alphaColor > 0):
		alphaColor -= 0.05
		label.position.y -= 2
		label.modulate = Color(color, alphaColor)
		timer.start()
		await timer.timeout
	
	label.queue_free()
	timer.queue_free()


func change_animation(nameAnimation):
	if nameAnimation == "run":
		animationTree["parameters/conditions/walk"] = false
		animationTree["parameters/conditions/run"] = true
	
	elif nameAnimation == "walk":
		animationTree["parameters/conditions/run"] = false
		animationTree["parameters/conditions/walk"] = true
	
	else:
		animationTree["parameters/conditions/" + nameAnimation] = true


func change_direction() -> void:
	direction *= -1
	sprite.flip_h = not sprite.flip_h
	for collision in collisions:
		collisions[collision].position.x *= -1


func chance_is_work(valueChance) -> bool:
	if valueChance == 0:
		return false
	
	if valueChance == 100:
		return true
	
	var forChance = RandomNumberGenerator.new()
	forChance.randomize()
	var chance = forChance.randi_range(1, 100)
	
	if chance <= valueChance:
		return true
	
	return false


func calculate_damage() -> int:
	var damage = baseDamage
	return damage


func take_damage(damage, sourse) -> void:
	remove_hp(damage)
	print("%s получил от %s %d урона" % [self.name, sourse.name, damage])


func remove_hp(numberHP) -> void:
	hp -= numberHP
	hpBar.value = hp
	
	hpBar.show()
	create_label(str(-(numberHP)), Color(1, 0, 0, 1))
	
	if hp > 0:
		hurt()
		return
	
	die()


func hurt() -> void:
	states["hurt"] = true
	sounds["hurt"].play()
	change_animation("hurt")


func die() -> void:
	states["alive"] = false
	velocity.x = 0
	change_animation("die")


func randomize_number_silver_coins(startRange, endRange) -> int:
	var forNumberSilverCoins = RandomNumberGenerator.new()
	forNumberSilverCoins.randomize()
	var numberSilverCoins = forNumberSilverCoins.randi_range(startRange, endRange)
	return numberSilverCoins


func spawn_silver_coin() -> void:
	var silverCoin = load("res://ScenesANDScripts/ForLevels/Items/Coins/Silver/SilverCoin.tscn").instantiate()
	silverCoin.position = position
	silverCoin.numberAddSilverCoins = randomize_number_silver_coins(1, 3)
	get_parent().call_deferred("add_child", silverCoin)


func spawn_apple() -> void:
	var apple = load("res://ScenesANDScripts/ForLevels/Items/Apple/Apple.tscn").instantiate()
	apple.position = position
	get_parent().call_deferred("add_child", apple)


func move() -> void:
	if states["alive"] and not states["attack"] and not states["hurt"]:
		velocity.x = baseMoveSpeed * direction
		if baseMoveSpeed == 100:
			change_animation("walk")
		elif baseMoveSpeed == 250:
			change_animation("run")
	else:
		velocity.x = 0



func _physics_process(delta):
	move()
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	move_and_slide()



func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack":
		animationTree["parameters/conditions/attack"] = false
		states["attack"] = false
		areas["rangeAttack"].set_deferred("monitoring", true)
	
	elif anim_name == "hurt":
		animationTree["parameters/conditions/hurt"] = false
		states["hurt"] = false
		areas["rangeAttack"].set_deferred("monitoring", true)
		
		if not seePlayer:
			change_direction()
	
	elif anim_name == "die":
		queue_free()
		
		if chance_is_work(60):
			spawn_silver_coin()
		else:
			spawn_apple()



func _on_area_range_attack_body_entered(body):
	if "Player" in body.name:
		areas["rangeAttack"].set_deferred("monitoring", false)
		
		if body.states["alive"] and states["alive"] and not states["hurt"]:
			states["attack"] = true
			change_animation("attack")


func _on_area_attack_body_entered(body):
	if "Player" in body.name:
		body.take_damage(calculate_damage(), self)
		sounds["hit"].play()


func _on_area_visibility_body_entered(body):
	if "Player" in body.name and body.states["alive"] and states["alive"]:
		seePlayer = true
		baseMoveSpeed = 250


func _on_area_visibility_body_exited(body):
	if "Player" in body.name and body.states["alive"] and states["alive"]:
		seePlayer = false
		baseMoveSpeed = 100


func _on_visible_on_screen_enabler_screen_entered():
	sprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	sprite.hide()
