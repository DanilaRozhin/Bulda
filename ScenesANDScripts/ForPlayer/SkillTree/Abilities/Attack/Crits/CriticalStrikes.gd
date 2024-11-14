class_name CriticalStrikes extends Abilities

var chanceCriticalStrike = 0
var increaseChanceCriticalStrikes = 8

var valueCriticalDamageMultiplier = 0
var increaseValueCriticalDamageMultiplier = 4



func update_global() -> void:
	GlobalSkillTree.criticalStrikes.currentLevel = currentLevel
	GlobalSkillTree.criticalStrikes.valueCriticalDamageMultiplier = valueCriticalDamageMultiplier
	GlobalSkillTree.criticalStrikes.chanceCriticalStrike = chanceCriticalStrike
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.criticalStrikes.currentLevel
	valueCriticalDamageMultiplier = GlobalSkillTree.criticalStrikes.valueCriticalDamageMultiplier
	chanceCriticalStrike = GlobalSkillTree.criticalStrikes.chanceCriticalStrike


func update_description() -> void:
	description.text = "Вау! Крит! Ваш урон увеличивается на %d с шансом %d%%" % [valueCriticalDamageMultiplier, chanceCriticalStrike]


func update_values() -> void:
	chanceCriticalStrike = currentLevel * increaseChanceCriticalStrikes
	valueCriticalDamageMultiplier = currentLevel * increaseValueCriticalDamageMultiplier
