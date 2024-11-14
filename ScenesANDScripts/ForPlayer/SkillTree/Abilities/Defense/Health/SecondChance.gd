class_name SecondChance extends Abilities

var hpAfterSkill = 0
var increaseHPAfterSkill = 25

var isActive = true


func update_global() -> void:
	GlobalSkillTree.secondChance.currentLevel = currentLevel
	GlobalSkillTree.secondChance.hpAfterSkill = hpAfterSkill
	
	
func update_local() -> void:
	currentLevel = GlobalSkillTree.secondChance.currentLevel
	hpAfterSkill = GlobalSkillTree.secondChance.hpAfterSkill


func update_description() -> void:
	description.text = "Один раз за уровень не позволяет смерти забрать вас, даруя %d%% от максимального здоровья." % [hpAfterSkill]


func update_values() -> void:
	hpAfterSkill = currentLevel * increaseHPAfterSkill
