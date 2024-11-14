class_name CrushingStrike extends Abilities

var chanceGainIncreaseDamage = 0
var increaseChanceGainIncreaseDamage = 10

var valueIncreaseDamage = 0
var increaseValueIncreaseDamage = 3

var duration = 0
var increaseDuration = 2

var isActive = false



func update_global() -> void:
	GlobalSkillTree.crushingStrike.currentLevel = currentLevel
	GlobalSkillTree.crushingStrike.chanceGainIncreaseDamage = chanceGainIncreaseDamage
	GlobalSkillTree.crushingStrike.valueIncreaseDamage = valueIncreaseDamage
	GlobalSkillTree.crushingStrike.duration = duration
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.crushingStrike.currentLevel
	chanceGainIncreaseDamage = GlobalSkillTree.crushingStrike.chanceGainIncreaseDamage
	valueIncreaseDamage = GlobalSkillTree.crushingStrike.valueIncreaseDamage
	duration = GlobalSkillTree.crushingStrike.duration


func update_description() -> void:
	description.text = "Ваш удар пробивает защиту противника с шансом %d%%, увеличивая урон на %d на %d сек." % [chanceGainIncreaseDamage, valueIncreaseDamage, duration]


func update_values() -> void:
	chanceGainIncreaseDamage = currentLevel * increaseChanceGainIncreaseDamage
	valueIncreaseDamage = currentLevel * increaseValueIncreaseDamage
	duration = currentLevel * increaseDuration
