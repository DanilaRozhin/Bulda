extends CharacterBody2D
class_name BasePlayer

const GRAVITY = 600
const JUMP_POWER = 410

@export var baseHP = 100
@export var baseDamage = 100
@export var baseMoveSpeed = 200.00

@onready var stats = $Stats
@onready var interface = $Interface

@onready var collision = $Collision
@onready var collisionAttack = $AreaAttack/CollisionAttack

@onready var animationTree = $AnimationTree
@onready var sprite = $Sprite
@onready var camera = $Camera

@onready var information = $Information
@onready var timerInformation = $Timers/TimerInformation

@onready var sounds = {
	"pickUPSword" : $Sounds/Objects/PickUpSword,
	"pickUPArmor" : $Sounds/Objects/PickUpArmor,
	"knockDoor" : $Sounds/Objects/KnockDoor,
	
	"hit" : $Sounds/Player/Hit,
	"hurt" : $Sounds/Player/Hurt,
	"weaponSwing" : $Sounds/Player/WeaponSwing,
	
	"deathByFall" : $Sounds/Player/DeathByFall,
	"die" : $Sounds/Player/Die
}

var states = {
	"alive" : true,
	"hurt" : false,
	"attack" : false,
	"jump" : false
}

var hp = 0

var canKnockDoor = false
var canLift = false



func _ready():
	hp = baseHP + GlobalSkillTree.whatDoesNotKill.valueIncreaseHealth
	update_hp()
	update_stats("HP")
	update_volume_sounds()
	GlobalInput.reset()
	GlobalSkillTree.disactivate_skills()


func show_button_action() -> void:
	interface.buttonsControl["action"].show()


func hide_button_action() -> void:
	interface.buttonsControl["action"].hide()


func update_volume_sounds() -> void:
	for sound in sounds:
		sounds[sound].volume_db = GlobalSettings.volumeSounds


func update_stats(nameStats) -> void:
	if nameStats == "Global":
		stats.update_global_stats_currency()
	
	elif nameStats in ["GoldCoins", "SilverCoins", "Keys"]:
		stats.update_stats_currency(nameStats)
	
	elif nameStats == "HP":
		stats.HPBar.value = hp
		stats.numberHP.text = str(hp)


func update_hp() -> void:
	stats.HPBar.max_value = baseHP + GlobalSkillTree.whatDoesNotKill.valueIncreaseHealth
	
	if hp > stats.HPBar.max_value:
		hp = stats.HPBar.max_value
		update_stats("HP")


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


func set_information(info) -> void:
	timerInformation.stop()
	
	information.text = info
	information.visible_characters = 0
	information.show()
	
	var timerInformationTextSpeed = create_timer(0.05)
	
	while(information.visible_characters < len(information.text)):
		information.visible_characters += 1
		timerInformationTextSpeed.start()
		await timerInformationTextSpeed.timeout
	
	timerInformationTextSpeed.queue_free()
	
	timerInformation.start()
	await timerInformation.timeout
	
	information.hide()
	information.text = " "


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


func calculate_chance_block() -> int:
	var chanceBlock = GlobalSkillTree.teachingDefense.chanceBlock
	return chanceBlock


func calculate_chance_evasion() -> int:
	var chanceEvasion = GlobalSkillTree.slipperyMan.chanceEvasion 
	
	if GlobalSkillTree.matrix.isActive:
		chanceEvasion += GlobalSkillTree.matrix.chanceEvasion
	
	return chanceEvasion


func calculate_defense() -> int:
	var defense = GlobalSkillTree.experienced.valueLessDamage
	return defense


func calculate_damage() -> int:
	var damage = baseDamage + GlobalSkillTree.combatSkill.valueIncreaseDamage
	
	if GlobalSkillTree.counterattack.isActive:
		damage += GlobalSkillTree.counterattack.valueIncreaseDamage
	
	if chance_is_work(GlobalSkillTree.crushingStrike.chanceGainIncreaseDamage):
		activate_skill("crushingStrike")
	
	if GlobalSkillTree.crushingStrike.isActive:
		damage += GlobalSkillTree.crushingStrike.valueIncreaseDamage
	
	if chance_is_work(GlobalSkillTree.criticalStrikes.chanceCriticalStrike):
		damage += GlobalSkillTree.criticalStrikes.valueCriticalDamageMultiplier
		damage += GlobalSkillTree.criticalMultiplier.valueIncreaseCriticalDamageMultiplier
	
	return damage


func calculate_move_speed() -> float:
	var moveSpeed = baseMoveSpeed * (1 + (float(GlobalSkillTree.easily100Meters.valueIncreaseMoveSpeed) / 100))
	
	if GlobalSkillTree.fasterThanArrow.isActive:
		moveSpeed *= 1 + (float(GlobalSkillTree.fasterThanArrow.valueIncreaseMoveSpeed) / 100)
	
	return moveSpeed


func try_evade() -> bool:
	var chanceEvasion = calculate_chance_evasion()
	
	if chance_is_work(chanceEvasion):
		create_label("Miss", Color(0, 1, 0.5, 1))
		return true
	
	return false


func try_block() -> bool:
	var chanceBlock = calculate_chance_block()
	
	if chance_is_work(chanceBlock):
		states["hurt"] = true
		velocity.x = 0
		hurt()
		create_label("Block", Color(0.9, 0, 0, 1))
		return true
	
	return false


func activate_skill(nameSkill) -> void:
	var skill = GlobalSkillTree.activatingSkills[nameSkill]
	
	if skill.currentLevel <= 0 or skill.isActive:
		return

	skill.isActive = true
	
	var timerDuration = create_timer(skill.duration)
	stats.add_buff(nameSkill, timerDuration)
	
	timerDuration.start()
	await timerDuration.timeout
	
	skill.isActive = false
	timerDuration.queue_free()


func take_damage(damage, sourse) -> void:
	if GlobalSkillTree.iDontFeelPain.isActive:
		return
	
	if try_evade():
		activate_skill("matrix")
		activate_skill("fasterThanArrow")
		return
	
	if try_block():
		activate_skill("counterattack")
		return
	
	var defense = calculate_defense()
	
	if (damage - defense) > 0:
		remove_hp(damage - defense)
		print("%s получил от %s %d урона" % [self.name, sourse.name, damage - defense])
	else:
		remove_hp(0)
	
	if chance_is_work(GlobalSkillTree.iDontFeelPain.chance):
		activate_skill("iDontFeelPain")


func remove_hp(numberHP) -> void:
	hp -= numberHP
	update_stats("HP")
	
	if hp > 0:
		hurt()
		create_label("-" + str(numberHP), Color(1, 0, 0, 1))
		return
	
	if GlobalSkillTree.secondChance.currentLevel > 0 and GlobalSkillTree.secondChance.isActive:
		GlobalSkillTree.secondChance.isActive = false
		hp = int(stats.HPBar.max_value * (float(GlobalSkillTree.secondChance.hpAfterSkill) / 100))
		update_stats("HP")
		create_label("Второй шанс", Color(0, 1, 0.5, 1))
		return
	
	die()


func add_hp(numberHP) -> void:
	if hp >= stats.HPBar.max_value:
		return
	
	hp += numberHP
	
	if hp > stats.HPBar.max_value:
		hp = stats.HPBar.max_value
	
	update_stats("HP")
	create_label("+" + str(numberHP), Color(0, 1, 0.5, 1))


func change_animation(nameAnimation):
	if nameAnimation == "idle":
		animationTree["parameters/conditions/run"] = false
		animationTree["parameters/conditions/jump"] = false
		animationTree["parameters/conditions/idle"] = true
	
	elif nameAnimation == "run":
		animationTree["parameters/conditions/idle"] = false
		animationTree["parameters/conditions/jump"] = false
		animationTree["parameters/conditions/run"] = true
	
	elif nameAnimation == "jump":
		animationTree["parameters/conditions/idle"] = false
		animationTree["parameters/conditions/run"] = false
		animationTree["parameters/conditions/jump"] = true
	
	else:
		animationTree["parameters/conditions/" + nameAnimation] = true


func change_direction(direction):
	if direction == "left":
		sprite.flip_h = true
		collisionAttack.position.x = abs(collisionAttack.position.x) * (-1)
		collision.position.x = abs(collision.position.x) * (-1)
	elif direction == "right":
		sprite.flip_h = false
		collisionAttack.position.x = abs(collisionAttack.position.x)
		collision.position.x = abs(collision.position.x)


func die() -> void:
	states["alive"] = false
	velocity.x = 0
	change_animation("die")
	sounds["die"].play()


func death_by_fall() -> void:
	states["alive"] = false
	velocity.x = 0
	hp = 0
	update_stats("HP")
	sounds["deathByFall"].play()


func move() -> void:
	if not GlobalInput.moveRight or not GlobalInput.moveLeft:
		velocity.x = 0
	
	if GlobalInput.moveRight and states["alive"] and not states["hurt"]:
		velocity.x = calculate_move_speed()
		change_direction("right")
		
		if is_on_floor():
			change_animation("run")
	
	elif GlobalInput.moveLeft and states["alive"] and not states["hurt"]:
		velocity.x = -calculate_move_speed()
		change_direction("left")
		
		if is_on_floor():
			change_animation("run")
		
	elif states["alive"] and not states["hurt"] and not states["attack"] and not states["jump"]:
		velocity.x = 0
		if is_on_floor():
			change_animation("idle")


func jump() -> void:
	if GlobalInput.jump and states["alive"] and not states["hurt"] and not states["jump"]:
		GlobalInput.jump = false
		states["jump"] = true
		velocity.y = -JUMP_POWER
		change_animation("jump")
	
	if is_on_floor():
		states["jump"] = false


func attack() -> void:
	if GlobalInput.attack and states["alive"] and not states["hurt"] and not states["attack"]:
		states["attack"] = true
		sounds["weaponSwing"].play()
		change_animation("attack")


func hurt() -> void:
	states["hurt"] = true
	velocity.x = 0
	sounds["hurt"].play()
	change_animation("hurt")


func lift() -> void:
	if GlobalInput.action and canLift and states["alive"] and not states["hurt"]:
		velocity.y = -calculate_move_speed()


func knock_door() -> void:
	if GlobalInput.action and canKnockDoor and states["alive"]:
		canKnockDoor = false
		sounds["knockDoor"].play()


func borders() -> void:
	if position.y >= 1500 and states["alive"]:
		death_by_fall()



func _physics_process(delta):
	move()
	jump()
	attack()
	lift()
	knock_door()
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	move_and_slide()
	
	borders()



func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack":
		animationTree["parameters/conditions/attack"] = false
		states["attack"] = false
		change_animation("idle")
	
	elif anim_name == "hurt":
		animationTree["parameters/conditions/hurt"] = false
		states["hurt"] = false
		change_animation("idle")
	
	elif anim_name == "die":
		if "FarmLevel" in str(get_parent()):
			get_parent().update_global()
		
		get_tree().change_scene_to_file("res://ScenesANDScripts/ForPlayer/DeathScreen/DeathScreen.tscn")


func _on_area_attack_body_entered(body):
	if ("Enemy" in body.name or "Boss" in body.name) and body.states["alive"]:
		sounds["hit"].play()
		body.take_damage(calculate_damage(), self)
		
		if GlobalSkillTree.chanceLifesteal.currentLevel == 0:
			return
		
		var chanceLifesteal = GlobalSkillTree.chanceLifesteal.chanceLifesteal
		
		if not chance_is_work(chanceLifesteal):
			return
		
		var powerLifesteal = GlobalSkillTree.chanceLifesteal.powerLifesteal + GlobalSkillTree.powerLifesteal.powerLifesteal
		add_hp(powerLifesteal)
	
	if "LootBox" in body.name:
		body.destruction()


func _on_death_by_fall_finished():
	if "FarmLevel" in str(get_parent()):
		get_parent().update_global()
	
	get_tree().change_scene_to_file("res://ScenesANDScripts/ForPlayer/DeathScreen/DeathScreen.tscn")


func _on_knock_door_finished():
	get_parent().get_node("Houses").get_node("HouseAlcoholic").speech_alcoholic()
