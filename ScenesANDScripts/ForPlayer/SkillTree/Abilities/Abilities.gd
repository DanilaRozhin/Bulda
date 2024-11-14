class_name Abilities

var labelCurrentLevel
var labelMaxLevel
var description
var button

var currentLevel = 0
var maxLevel = 0

var priceGreenPoints = 0
var priceBluePoints = 0


func update_label() -> void:
	labelCurrentLevel.text = str(currentLevel)


func update_max_level() -> void:
	maxLevel = int(labelMaxLevel.text)


func upgrade() -> void:
	currentLevel += 1
	update_label()
	update_values()
	update_description()


func downgrade() -> void:
	currentLevel = 0
	update_label()
	update_values()
	update_description()


func update_values() -> void:
	pass #реализация в дочернем классе


func update_description() -> void:
	pass #реализация в дочернем классе
