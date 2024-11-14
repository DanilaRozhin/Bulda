class_name WhatDoesNotKill extends Abilities

var valueIncreaseHealth = 0
var increaseValueIncreaseHealth = 10



func update_global() -> void:
	GlobalSkillTree.whatDoesNotKill.currentLevel = currentLevel
	GlobalSkillTree.whatDoesNotKill.valueIncreaseHealth = valueIncreaseHealth
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.whatDoesNotKill.currentLevel
	valueIncreaseHealth = GlobalSkillTree.whatDoesNotKill.valueIncreaseHealth


func update_description() -> void:
	description.text = "Ваше максимальное здоровье увеличивается на %d" % [valueIncreaseHealth]


func update_values() -> void:
	valueIncreaseHealth = currentLevel * increaseValueIncreaseHealth
