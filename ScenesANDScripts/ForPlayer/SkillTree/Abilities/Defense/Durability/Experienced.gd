class_name Experienced extends Abilities

var valueLessDamage = 0
var increaseValueLessDamage = 2



func update_global() -> void:
	GlobalSkillTree.experienced.currentLevel = currentLevel
	GlobalSkillTree.experienced.valueLessDamage = valueLessDamage


func update_local() -> void:
	currentLevel = GlobalSkillTree.experienced.currentLevel
	valueLessDamage = GlobalSkillTree.experienced.valueLessDamage


func update_description() -> void:
	description.text = "Бесконечные сражения закаляют вас, снижая входящий урон на %d" % [valueLessDamage]


func update_values() -> void:
	valueLessDamage = currentLevel * increaseValueLessDamage
