extends BasePlayer

@export var baseChanceBlock = 0



func calculate_chance_block() -> int:
	var chanceBlock = baseChanceBlock + GlobalSkillTree.teachingDefense.chanceBlock
	return chanceBlock
