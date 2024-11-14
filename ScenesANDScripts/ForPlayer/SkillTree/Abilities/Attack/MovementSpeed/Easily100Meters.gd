class_name Easily100Meters extends Abilities

var valueIncreaseMoveSpeed = 0
var increaseValueIncreaseMoveSpeed = 5



func update_global() -> void:
	GlobalSkillTree.easily100Meters.currentLevel = currentLevel
	GlobalSkillTree.easily100Meters.valueIncreaseMoveSpeed = valueIncreaseMoveSpeed


func update_local() -> void:
	currentLevel = GlobalSkillTree.easily100Meters.currentLevel
	valueIncreaseMoveSpeed = GlobalSkillTree.easily100Meters.valueIncreaseMoveSpeed


func update_description() -> void:
	description.text = "Скорость вашего передвижения увеличена на %d%%" % [valueIncreaseMoveSpeed]


func update_values() -> void:
	valueIncreaseMoveSpeed = currentLevel * increaseValueIncreaseMoveSpeed
