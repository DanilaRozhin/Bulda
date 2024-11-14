class_name Counterattack extends Abilities

var valueIncreaseDamage = 0
var increaseValueIncreaseDamage = 4

var duration = 0
var increaseDuration = 2

var isActive = false


func update_global() -> void:
	GlobalSkillTree.counterattack.currentLevel = currentLevel
	GlobalSkillTree.counterattack.valueIncreaseDamage = valueIncreaseDamage
	GlobalSkillTree.counterattack.duration = duration
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.counterattack.currentLevel
	valueIncreaseDamage = GlobalSkillTree.counterattack.valueIncreaseDamage
	duration = GlobalSkillTree.counterattack.duration


func update_description() -> void:
	description.text = "После успешного блокирования ваш урон увеличивается на %d в течении %d сек." % [valueIncreaseDamage, duration]


func update_values() -> void:
	valueIncreaseDamage = currentLevel * increaseValueIncreaseDamage
	duration = currentLevel * increaseDuration
