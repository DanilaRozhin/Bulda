class_name FasterThanArrow extends Abilities

var valueIncreaseMoveSpeed = 0
var increaseValueIncreaseMoveSpeed = 5

var duration = 0
var increaseDuration = 3

var isActive = false



func update_global() -> void:
	GlobalSkillTree.fasterThanArrow.currentLevel = currentLevel
	GlobalSkillTree.fasterThanArrow.valueIncreaseMoveSpeed = valueIncreaseMoveSpeed
	GlobalSkillTree.fasterThanArrow.duration = duration


func update_local() -> void:
	currentLevel = GlobalSkillTree.fasterThanArrow.currentLevel
	valueIncreaseMoveSpeed = GlobalSkillTree.fasterThanArrow.valueIncreaseMoveSpeed
	duration = GlobalSkillTree.fasterThanArrow.duration	


func update_description() -> void:
	description.text = "При уклонении, ваша скорость передвижение возрастает на %d%% на %d сек." % [valueIncreaseMoveSpeed, duration]


func update_values() -> void:
	valueIncreaseMoveSpeed = currentLevel * increaseValueIncreaseMoveSpeed
	duration = currentLevel * increaseDuration
