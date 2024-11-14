class_name PowerLifesteal extends Abilities

var powerLifesteal = 0
var valueIncreasePowerLifesteal = 5



func update_global() -> void:
	GlobalSkillTree.powerLifesteal.currentLevel = currentLevel
	GlobalSkillTree.powerLifesteal.powerLifesteal = powerLifesteal


func update_local() -> void:
	currentLevel = GlobalSkillTree.powerLifesteal.currentLevel
	powerLifesteal = GlobalSkillTree.powerLifesteal.powerLifesteal


func update_description() -> void:
	description.text = "Ваш вампиризм от атак увеличивается на %d" % [powerLifesteal]


func update_values() -> void:
	powerLifesteal = currentLevel * valueIncreasePowerLifesteal
