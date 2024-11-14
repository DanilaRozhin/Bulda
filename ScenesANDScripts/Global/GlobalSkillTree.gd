extends Node

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

var activatingSkills = {
	"iDontFeelPain" : iDontFeelPain,
	"matrix" : matrix,
	"counterattack" : counterattack,
	"crushingStrike" : crushingStrike,
	"fasterThanArrow" : fasterThanArrow
}

var savePath = "user://save_skillTree.dat"

var dataDefenseSkills = {
	"experienced" : "0",
	"iDontFeelPain" : "0",
	"slipperyMan" : "0",
	"matrix" : "0",
	"teachingDefense" : "0",
	"counterattack" : "0",
	"whatDoesNotKill" : "0",
	"secondChance" : "0"
}

var dataAttackSkills = {
	"combatSkill" : "0",
	"crushingStrike" : "0",
	"easily100Meters" : "0",
	"fasterThanArrow" : "0",
	"criticalStrikes" : "0",
	"criticalMultiplier" : "0",
	"chanceLifesteal" : "0",
	"powerLifesteal" : "0"
}



func disactivate_skills() -> void:
	for skill in activatingSkills:
		activatingSkills[skill].isActive = false
	
	secondChance.isActive = true


func save_data() -> void:
	for data in dataDefenseSkills:
		dataDefenseSkills[data] = str(defenseSkills[data].currentLevel)
	
	for data in dataAttackSkills:
		dataAttackSkills[data] = str(attackSkills[data].currentLevel)
	
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_line(JSON.stringify(dataDefenseSkills))
	file.store_line(JSON.stringify(dataAttackSkills))


func load_data() -> void:
	if not FileAccess.file_exists(savePath):
		return
	
	var file = FileAccess.open(savePath, FileAccess.READ)
	dataDefenseSkills = JSON.parse_string(file.get_line())
	dataAttackSkills = JSON.parse_string(file.get_line())

	for data in dataDefenseSkills:
		defenseSkills[data].currentLevel = int(dataDefenseSkills[data])
		defenseSkills[data].update_values()
	
	for data in dataAttackSkills:
		attackSkills[data].currentLevel = int(dataAttackSkills[data])
		attackSkills[data].update_values()
