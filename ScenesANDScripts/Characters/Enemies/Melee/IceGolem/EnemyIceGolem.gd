extends BaseEnemy

@export var baseLessDamageTaken = 0



func calculate_defense() -> int:
	var defense = baseLessDamageTaken
	return defense


func take_damage(damage, sourse) -> void:
	var defense = calculate_defense()
	if (damage - defense) > 0:
		super.take_damage(damage - defense, sourse)
