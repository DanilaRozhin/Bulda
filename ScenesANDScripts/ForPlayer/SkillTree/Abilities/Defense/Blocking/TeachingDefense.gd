class_name TeachingDefense extends Abilities

var chanceBlock = 0
var increaseChanceBlock = 7



func update_global() -> void:
	GlobalSkillTree.teachingDefense.currentLevel = currentLevel
	GlobalSkillTree.teachingDefense.chanceBlock = chanceBlock
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.teachingDefense.currentLevel
	chanceBlock = GlobalSkillTree.teachingDefense.chanceBlock


func update_description() -> void:
	description.text = "Вы раскрываете потенциал вашей защиты, блокируя входящий урон с шансом %d%%" % [chanceBlock]


func update_values() -> void:
	chanceBlock = currentLevel * increaseChanceBlock
