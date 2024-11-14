class_name ChanceLifesteal extends Abilities

var chanceLifesteal = 0
var powerLifesteal = 0

var valueIncreaseChanceLifesteal = 5
var valueIncreasePowerLifesteal = 2



func update_global() -> void:
	GlobalSkillTree.chanceLifesteal.currentLevel = currentLevel
	GlobalSkillTree.chanceLifesteal.chanceLifesteal = chanceLifesteal
	GlobalSkillTree.chanceLifesteal.powerLifesteal = powerLifesteal


func update_local() -> void:
	currentLevel = GlobalSkillTree.chanceLifesteal.currentLevel
	chanceLifesteal = GlobalSkillTree.chanceLifesteal.chanceLifesteal
	powerLifesteal = GlobalSkillTree.chanceLifesteal.powerLifesteal


func update_description() -> void:
	description.text = "Ваши атаки с шансом %d%% восстанавливают %d здоровья" % [chanceLifesteal, powerLifesteal]


func update_values() -> void:
	chanceLifesteal = currentLevel * valueIncreaseChanceLifesteal
	powerLifesteal = currentLevel * valueIncreasePowerLifesteal
