extends Control

#----------DefenseSkills----------

#---Durability---
var experienced = Experienced.new()
var iDontFeelPain = IDontFeelPain.new()

#---Evasion---
var slipperyMan = SlipperyMan.new()
var matrix = Matrix.new()

#---Blocking---
var teachingDefense = TeachingDefense.new()
var counterattack = Counterattack.new()

#---Health---
var whatDoesNotKill = WhatDoesNotKill.new()
var secondChance = SecondChance.new()


#----------AttackSkills----------

#---Damage---
var combatSkill = CombatSkill.new()
var crushingStrike = CrushingStrike.new()

#---MovementSpeed---
var easily100Meters = Easily100Meters.new()
var fasterThanArrow = FasterThanArrow.new()

#---Crits---
var criticalStrikes = CriticalStrikes.new()
var criticalMultiplier = CriticalMultiplier.new()

#---Lifesteal---
var chanceLifesteal = ChanceLifesteal.new()
var powerLifesteal = PowerLifesteal.new()

@onready var labelNumberGreenPoints = $CanvasLayer/Interface/UpperPanel/Points/GreenPoints/NumberGreenPoints
@onready var labelNumberBluePoints = $CanvasLayer/Interface/UpperPanel/Points/BluePoints/NumberBluePoints

@onready var skillTree = $CanvasLayer
@onready var information = $CanvasLayer/Interface/UpperPanel/Information/Information
@onready var soundAccept = $Accept

var numberGreenPoints
var numberBluePoints

var defenseSkills = {
	"experienced" : experienced,
	"iDontFeelPain" : iDontFeelPain,
	"slipperyMan" : slipperyMan,
	"matrix" : matrix,
	"teachingDefense" : teachingDefense,
	"counterattack" : counterattack,
	"whatDoesNotKill" : whatDoesNotKill,
	"secondChance" : secondChance
}

var attackSkills = {
	"combatSkill" : combatSkill,
	"crushingStrike" : crushingStrike,
	"easily100Meters" : easily100Meters,
	"fasterThanArrow" : fasterThanArrow,
	"criticalStrikes" :criticalStrikes,
	"criticalMultiplier" : criticalMultiplier,
	"chanceLifesteal" : chanceLifesteal,
	"powerLifesteal" : powerLifesteal
}



func _ready():
	if "Player" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		show_skill_tree()
		return
	
	process_mode = Node.PROCESS_MODE_INHERIT
	skillTree.hide()


func show_skill_tree() -> void:
	load_labels()
	load_buttons()
	load_prices()
	load_descriptions()
	
	update_local()
	update_labels_skills()
	update_labels_points()
	update_descriptions()
	
	disable_buttons_skills()
	
	soundAccept.volume_db = GlobalSettings.volumeSounds
	information.text = " "
	skillTree.show()
	

func load_labels() -> void:
	var labelsCurrentLevelDefenseSkills = get_tree().get_nodes_in_group("labelsCurrentLevelDefenseSkills")
	var labelsMaxLevelDefenseSkills = get_tree().get_nodes_in_group("labelsMaxLevelDefenseSkills")
	
	var labelsCurrentLevelAttackSkills = get_tree().get_nodes_in_group("labelsCurrentLevelAttackSkills")
	var labelsMaxLevelAttackSkills = get_tree().get_nodes_in_group("labelsMaxLevelAttackSkills")
	
	var labelCurrentLevelSkill = 0
	var labelMaxLevelSkill = 0
	
	for skill in defenseSkills:
		defenseSkills[skill].labelCurrentLevel = labelsCurrentLevelDefenseSkills[labelCurrentLevelSkill]
		defenseSkills[skill].labelMaxLevel = labelsMaxLevelDefenseSkills[labelMaxLevelSkill]
		
		labelCurrentLevelSkill += 1
		labelMaxLevelSkill += 1

	labelCurrentLevelSkill = 0
	labelMaxLevelSkill = 0
	
	for skill in attackSkills:
		attackSkills[skill].labelCurrentLevel = labelsCurrentLevelAttackSkills[labelCurrentLevelSkill]
		attackSkills[skill].labelMaxLevel = labelsMaxLevelAttackSkills[labelMaxLevelSkill]
		
		labelCurrentLevelSkill += 1
		labelMaxLevelSkill += 1
	
	labelCurrentLevelSkill = 0
	labelMaxLevelSkill = 0


func load_buttons() -> void:
	var buttonsDefenseSkills = get_tree().get_nodes_in_group("buttonsDefenseSkills")
	var buttonsAttackSkills = get_tree().get_nodes_in_group("buttonsAttackSkills")
	
	var buttonSkill = 0
	
	for skill in defenseSkills:
		defenseSkills[skill].button = buttonsDefenseSkills[buttonSkill]
		buttonSkill += 1
		
	buttonSkill = 0
	
	for skill in attackSkills:
		attackSkills[skill].button = buttonsAttackSkills[buttonSkill]
		buttonSkill += 1
		
	buttonSkill = 0


func load_prices() -> void:
	var priceGreenPointsDefenseSkills = get_tree().get_nodes_in_group("priceGreenPointsDefenseSkills")
	var priceBluePointsDefenseSkills = get_tree().get_nodes_in_group("priceBluePointsDefenseSkills")

	var priceGreenPointsAttackSkills = get_tree().get_nodes_in_group("priceGreenPointsAttackSkills")
	var priceBluePointsAttackSkills = get_tree().get_nodes_in_group("priceBluePointsAttackSkills")
	
	var priceGreenPoints = 0
	var priceBluePoints = 0
	
	for skill in defenseSkills:
		defenseSkills[skill].priceGreenPoints = int(priceGreenPointsDefenseSkills[priceGreenPoints].text)
		defenseSkills[skill].priceBluePoints = int(priceBluePointsDefenseSkills[priceBluePoints].text)
		
		priceGreenPoints += 1
		priceBluePoints += 1
	
	priceGreenPoints = 0
	priceBluePoints = 0
	
	for skill in attackSkills:
		attackSkills[skill].priceGreenPoints = int(priceGreenPointsAttackSkills[priceGreenPoints].text)
		attackSkills[skill].priceBluePoints = int(priceBluePointsAttackSkills[priceBluePoints].text)
		
		priceGreenPoints += 1
		priceBluePoints += 1
		
	priceGreenPoints = 0
	priceBluePoints = 0


func load_descriptions() -> void:
	var descriptionsDefenseSkills = get_tree().get_nodes_in_group("descriptionsDefenseSkills")
	var descriptionsAttackSkills = get_tree().get_nodes_in_group("descriptionsAttackSkills")

	var description = 0

	for skill in defenseSkills:
		defenseSkills[skill].description = descriptionsDefenseSkills[description]
		description += 1
	
	description = 0
	
	for skill in attackSkills:
		attackSkills[skill].description = descriptionsAttackSkills[description]
		description += 1
	
	description = 0


func update_local() -> void:
	for skill in defenseSkills:
		defenseSkills[skill].update_local()
		defenseSkills[skill].update_max_level()
	
	for skill in attackSkills:
		attackSkills[skill].update_local()
		attackSkills[skill].update_max_level()
	
	numberGreenPoints = GlobalPlayer.numberGreenPoints
	numberBluePoints = GlobalPlayer.numberBluePoints


func update_labels_skills() -> void:
	for skill in defenseSkills:
		defenseSkills[skill].update_label()

	for skill in attackSkills:
		attackSkills[skill].update_label()


func update_labels_points() -> void:
	labelNumberGreenPoints.text = str(numberGreenPoints)
	labelNumberBluePoints.text = str(numberBluePoints)


func update_descriptions() -> void:
	for skill in defenseSkills:
		defenseSkills[skill].update_description()

	for skill in attackSkills:
		attackSkills[skill].update_description()


func update_global() -> void:
	for skill in defenseSkills:
		defenseSkills[skill].update_global()
	
	for skill in attackSkills:
		attackSkills[skill].update_global()
		
	GlobalPlayer.numberGreenPoints = numberGreenPoints
	GlobalPlayer.numberBluePoints = numberBluePoints


func hide_skill_tree() -> void:
	if "Player" in str(get_parent()):
		get_parent().get_node("Stats").show_stats()
		get_parent().get_node("Interface").show_interface()
		get_tree().paused = false
	
		queue_free()


func possible_upgrade(skill) -> bool:
	if skill.currentLevel >= skill.maxLevel:
		information.set("theme_override_colors/font_color", Color("dc0000"))
		information.text = "Умение уже прокачено на максимум"
		return false
	
	if numberGreenPoints < skill.priceGreenPoints:
		information.set("theme_override_colors/font_color", Color("dc0000"))
		information.text = "У вас недостаточно зелёных очков"	
		return false
	
	if numberBluePoints < skill.priceBluePoints:
		information.set("theme_override_colors/font_color", Color("dc0000"))
		information.text = "У вас недостаточно синих очков"	
		return false
	
	return true


func upgrade(skill, typeSkill) -> void:
	if typeSkill == "defense":
		skill = defenseSkills[skill]
	elif typeSkill == "attack":
		skill = attackSkills[skill]

	if not possible_upgrade(skill):
		return
	
	skill.upgrade()
	numberGreenPoints -= skill.priceGreenPoints
	numberBluePoints -= skill.priceBluePoints
	disable_buttons_skills()
	update_labels_points()
	
	information.set("theme_override_colors/font_color", Color(0, 1, 0))
	information.text = "Умение успешно прокачено. Не забудьте подтвердить!"


func reset_skills(typeSkills) -> void:
	var skills
	
	if typeSkills == "defense":
		skills = defenseSkills
	elif typeSkills == "attack":
		skills = attackSkills
	
	for skill in skills:
		if skills[skill].currentLevel <= 0:
			continue
		
		numberGreenPoints += skills[skill].priceGreenPoints * skills[skill].currentLevel
		numberBluePoints += skills[skill].priceBluePoints * skills[skill].currentLevel
		skills[skill].downgrade()
	
	disable_buttons_skills()
	update_labels_points()
	
	information.set("theme_override_colors/font_color", Color(0, 1, 0))
	information.text = "Ветка успешно сброшена. Не забудьте подтвердить!"


func disable_button_skill(skill1, skill2) -> void:
	if skill1.currentLevel < skill1.maxLevel:
		skill2.button.disabled = true
	else:
		skill2.button.disabled = false


func disable_buttons_skills() -> void:
	for i in range(0, defenseSkills.size() - 1, 2):
		disable_button_skill(defenseSkills.values()[i], defenseSkills.values()[i + 1])
	
	for i in range(0, attackSkills.size() - 1, 2):
		disable_button_skill(attackSkills.values()[i], attackSkills.values()[i + 1])



func _on_accept_pressed():
	update_global()
	GlobalSkillTree.save_data()
	GlobalPlayer.save_data()
	
	if "Player" in str(get_parent()):
		get_parent().update_hp()
	
	soundAccept.play()
	information.set("theme_override_colors/font_color", Color(0, 1, 0))
	information.text = "Прокачка умений успешно подтверждена"


func _on_close_skill_tree_pressed():
	hide_skill_tree()


func _on_skill_pressed(skill, typeSkill):
	upgrade(skill, typeSkill)


func _on_reset_skills_pressed(typeSkills):
	reset_skills(typeSkills)
