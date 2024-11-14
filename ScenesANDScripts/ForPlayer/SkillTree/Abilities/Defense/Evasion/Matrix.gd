class_name Matrix extends Abilities

var chanceEvasion = 0
var increaseChanceEvasion = 3

var duration = 0
var increaseDuration = 5

var isActive = false



func update_global() -> void:
	GlobalSkillTree.matrix.currentLevel = currentLevel
	GlobalSkillTree.matrix.chanceEvasion = chanceEvasion
	GlobalSkillTree.matrix.duration = duration
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.matrix.currentLevel
	chanceEvasion = GlobalSkillTree.matrix.chanceEvasion
	duration = GlobalSkillTree.matrix.duration


func update_description() -> void:
	description.text = "При уклонении в бою, вы повышаете шанс уклонения ещё на %d%% на %d сек." % [chanceEvasion, duration]


func update_values() -> void:
	chanceEvasion = currentLevel * increaseChanceEvasion
	duration = currentLevel * increaseDuration
