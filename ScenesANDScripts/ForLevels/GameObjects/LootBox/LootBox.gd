extends StaticBody2D


@onready var animatedSprite = $AnimatedSprite
@onready var collision = $Collision
@onready var soundDestruction = $Destruction



func _ready():
	animatedSprite.hide()



func destruction() -> void:
	collision.set_deferred("disabled", true)
	animatedSprite.play("destruction")
	soundDestruction.volume_db = GlobalSettings.volumeSounds
	soundDestruction.play()


func chance_is_work(valueChance) -> bool:
	if valueChance == 0:
		return false
	
	if valueChance == 100:
		return true
	
	var forChance = RandomNumberGenerator.new()
	forChance.randomize()
	var chance = forChance.randi_range(1, 100)
	
	if chance <= valueChance:
		return true
	
	return false


func randomize_number_silver_coins(startRange, endRange) -> int:
	var forNumberSilverCoins = RandomNumberGenerator.new()
	forNumberSilverCoins.randomize()
	var numberSilverCoins = forNumberSilverCoins.randi_range(startRange, endRange)
	return numberSilverCoins


func spawn_silver_coin(chanceSpawn) -> void:
	if chance_is_work(chanceSpawn):
		var silverCoin = load("res://ScenesANDScripts/ForLevels/Items/Coins/Silver/SilverCoin.tscn").instantiate()
		silverCoin.position.x = position.x
		silverCoin.position.y = position.y - 25
		silverCoin.numberAddSilverCoins = randomize_number_silver_coins(1, 2)
		get_parent().call_deferred("add_child", silverCoin)



func _on_destruction_finished():
	queue_free()
	spawn_silver_coin(60)


func _on_visible_on_screen_enabler_screen_entered():
	animatedSprite.show()


func _on_visible_on_screen_enabler_screen_exited():
	animatedSprite.hide()
