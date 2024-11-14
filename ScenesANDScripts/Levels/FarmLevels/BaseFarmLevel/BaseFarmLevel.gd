extends Node2D
class_name BaseFarmLevel

@export var cameraLimit = 0

@onready var player #инициализация в дочернем классе
@onready var markers #инициализация в дочернем классе
@onready var enemies #инициализация в дочернем классе

@onready var music = $Music


var numberSilverCoins = 0
var numberGoldCoins = 0
var numberKeys = 0

var numberKeysFromGlobal = GlobalPlayer.numberKeys

var numberWave = 0
var playerInAreaNextWave = false


func _ready():
	player.camera.limit_right = cameraLimit
	next_wave()



func update_volume_music() -> void:
	music.volume_db = GlobalSettings.volumeMusic


func update_global() -> void:
	GlobalPlayer.numberSilverCoins += numberSilverCoins
	GlobalPlayer.numberGoldCoins += numberGoldCoins
	GlobalPlayer.numberKeys = numberKeysFromGlobal
	GlobalPlayer.numberKeys += numberKeys
	GlobalPlayer.save_data()


func add_key(numKeys) -> void:
	numberKeys += numKeys


func add_silver_coin(numSilverCoins) -> void:
	numberSilverCoins += numSilverCoins


func add_gold_coin(numGoldCoins) -> void:
	numberGoldCoins += numGoldCoins


func remove_key(numKeys) -> void:
	numberKeysFromGlobal -= numKeys


func randomize_who_spawn(listVariants) -> String:
	var startRange = 0
	var endRange = listVariants.size() - 1
	
	var forNumberWhoSpawn = RandomNumberGenerator.new()
	forNumberWhoSpawn.randomize()
	var numberWhoSpawn = forNumberWhoSpawn.randi_range(startRange, endRange)
	var whoSpawn = listVariants[numberWhoSpawn]
	
	return whoSpawn


func spawn_enemy(positionEnemy, numberEnemy) -> void:
	var selectedEnemy = randomize_who_spawn(enemies.keys())
	var enemy = enemies[selectedEnemy].instantiate()
	enemy.name = "Enemy" + str(numberEnemy)
	enemy.position = positionEnemy
	enemy.hp += numberWave * 5
	enemy.baseDamage += numberWave * 3
	get_node("Enemies").call_deferred("add_child", enemy)


func spawn_apple(positionApple, numberApple) -> void:
	var apple = load("res://ScenesANDScripts/ForLevels/Items/Apple/Apple.tscn").instantiate()
	apple.name = "Apple" + str(numberApple)
	apple.position = positionApple
	get_node("CollectableObjects").call_deferred("add_child", apple)


func next_wave() -> void:
	numberWave += 1
	var countSpawnedApples = 0
	var countSpawnedEnemies = 0
	
	for numberMarker in markers:
		var whoSpawn = ""
		var averageNumberMarkers = int (markers.size() / 2)

		if countSpawnedApples >= averageNumberMarkers and countSpawnedEnemies < averageNumberMarkers:
			whoSpawn = "Enemy"
		elif countSpawnedEnemies >= averageNumberMarkers and countSpawnedApples < averageNumberMarkers:
			whoSpawn = "Apple"
		else:
			whoSpawn = randomize_who_spawn(["Enemy", "Apple"])
		
		if whoSpawn == "Enemy" or whoSpawn == "1":
			spawn_enemy(markers[numberMarker].position, countSpawnedEnemies)
			countSpawnedEnemies += 1
		elif whoSpawn == "Apple" or whoSpawn == "2":
			spawn_apple(markers[numberMarker].position, countSpawnedApples)
			countSpawnedApples += 1


func check_left_enemies() -> int:
	var leftEnemies = 0
	
	for numberChild in range(get_node("Enemies").get_child_count()):
		if "Enemy" in str(get_node("Enemies").get_child(numberChild)):
			leftEnemies += 1
	
	return leftEnemies



func _physics_process(_delta):
	if GlobalInput.action and playerInAreaNextWave:
		GlobalInput.action = false
		var leftEnemies = check_left_enemies()
	
		if leftEnemies == 0:
			next_wave()
		else:
			player.set_information("Для начала следующей волны, мне нужно разобраться с этой. Осталось врагов: " + str(leftEnemies))



func _on_area_next_wave_body_entered(body):
	if "Player" in body.name:
		playerInAreaNextWave = true
		body.show_button_action()


func _on_area_next_wave_body_exited(body):
	if "Player" in body.name:
		playerInAreaNextWave = false
		body.hide_button_action()
