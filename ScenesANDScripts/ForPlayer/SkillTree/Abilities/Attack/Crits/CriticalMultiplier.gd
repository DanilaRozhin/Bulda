class_name CriticalMultiplier extends Abilities

var valueIncreaseCriticalDamageMultiplier = 0
var increaseValueIncreaseCriticalDamageMultiplier = 10



func update_global() -> void:
	GlobalSkillTree.criticalMultiplier.currentLevel = currentLevel
	GlobalSkillTree.criticalMultiplier.valueIncreaseCriticalDamageMultiplier = valueIncreaseCriticalDamageMultiplier
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.criticalMultiplier.currentLevel
	valueIncreaseCriticalDamageMultiplier = GlobalSkillTree.criticalMultiplier.valueIncreaseCriticalDamageMultiplier


func update_description() -> void:
	description.text = "Урон? Вот урон! Сила вашего критического удара увеличивается на %d" % [valueIncreaseCriticalDamageMultiplier]


func update_values() -> void:
	valueIncreaseCriticalDamageMultiplier = currentLevel * increaseValueIncreaseCriticalDamageMultiplier
