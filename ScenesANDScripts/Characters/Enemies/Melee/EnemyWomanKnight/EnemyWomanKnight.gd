extends BaseEnemy

@export var baseChanceBlock = 0
@export var baseLessDamageTaken = 0



func try_block() -> bool:
	var chanceBlock = baseChanceBlock
	
	if chance_is_work(chanceBlock):
		states["hurt"] = true
		change_animation("hurt")
		create_label("Block", Color(0.9, 0, 0, 1))
		return true
	
	return false


func calculate_defense() -> int:
	var defense = baseLessDamageTaken
	return defense


func take_damage(damage, sourse) -> void:
	if try_block():
		return
	
	var defense = calculate_defense()
	if (damage - defense) > 0:
		super.take_damage(damage - defense, sourse)
