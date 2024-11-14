class_name IDontFeelPain extends Abilities

var duration = 0
var increaseDuration = 2

var chance = 0
var increaseChance = 5

var isActive = false



func update_global() -> void:
	GlobalSkillTree.iDontFeelPain.currentLevel = currentLevel
	GlobalSkillTree.iDontFeelPain.duration = duration
	GlobalSkillTree.iDontFeelPain.chance = chance
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.iDontFeelPain.currentLevel
	duration = GlobalSkillTree.iDontFeelPain.duration
	chance = GlobalSkillTree.iDontFeelPain.chance


func update_description() -> void:
	description.text = "Невероятная выносливость позволяет игнорировать урон в течении %d сек. с шансом %d%%" % [duration, chance]


func update_values() -> void:
	duration = currentLevel * increaseDuration
	chance = currentLevel * increaseChance
