class_name CombatSkill extends Abilities

var valueIncreaseDamage = 0
var increaseValueIncreaseDamage = 3



func update_global() -> void:
	GlobalSkillTree.combatSkill.currentLevel = currentLevel
	GlobalSkillTree.combatSkill.valueIncreaseDamage = valueIncreaseDamage
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.combatSkill.currentLevel
	valueIncreaseDamage = GlobalSkillTree.combatSkill.valueIncreaseDamage


func update_description() -> void:
	description.text = "Вы постигаете исскуство битвы и ваш урон увеличивается на %d" % [valueIncreaseDamage]


func update_values() -> void:
	valueIncreaseDamage = currentLevel * increaseValueIncreaseDamage
