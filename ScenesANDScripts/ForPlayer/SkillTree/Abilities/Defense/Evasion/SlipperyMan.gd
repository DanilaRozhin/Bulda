class_name SlipperyMan extends Abilities

var chanceEvasion = 0
var increaseChanceEvasion = 5



func update_global() -> void:
	GlobalSkillTree.slipperyMan.currentLevel = currentLevel
	GlobalSkillTree.slipperyMan.chanceEvasion = chanceEvasion
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.slipperyMan.currentLevel
	chanceEvasion = GlobalSkillTree.slipperyMan.chanceEvasion


func update_description() -> void:
	description.text = "Ловкими движениями вы уходите от ударов противника с шансом %d%%" % [chanceEvasion]


func update_values() -> void:
	chanceEvasion = currentLevel * increaseChanceEvasion
