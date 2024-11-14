extends Control

@onready var stats = $CanvasLayer

@onready var labelsNumberGlobalCurrency = {
	"goldCoins" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberGoldCoins/NumberGlobalGoldCoins",
	"silverCoins" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberSilverCoins/NumberGlobalSilverCoins",
	"keys" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberKeys/NumberGlobalKeys"
}

@onready var labelsNumberLocalCurrency = {
	"goldCoins" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberGoldCoins/NumberLocalGoldCoins",
	"silverCoins" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberSilverCoins/NumberLocalSilverCoins",
	"keys" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberKeys/NumberLocalKeys"
}

@onready var labelsAddLocalCurrency = {
	"goldCoins" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberGoldCoins/NumberAddLocalGoldCoins",
	"silverCoins" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberSilverCoins/NumberAddLocalSilverCoins",
	"keys" : $"CanvasLayer/Margins/Stats&Buffs/Stats/MarginsCoins&Keys/Coins&Keys/NumberKeys/NumberAddLocalKeys"
}

@onready var HPBar = $"CanvasLayer/Margins/Stats&Buffs/Stats/Icon&HpBar/HPBar"
@onready var numberHP = $"CanvasLayer/Margins/Stats&Buffs/Stats/Icon&HpBar/HPBar/NumberHP"
@onready var iconPlayer = $"CanvasLayer/Margins/Stats&Buffs/Stats/Icon&HpBar/IconPlayer"

var animationAddCurrencyFinished = {
	"goldCoins" : true,
	"silverCoins" : true,
	"keys" : true
}



func _ready():
	load_icon()
	update_global_stats_currency()
	values_stats_to_default()



func load_icon() -> void:
	if "PlayerKnight" in str(get_parent()):
		iconPlayer.texture = load("res://AllTextures/ForPlayer/Stats/Icons/IconKnight.png")
	elif "PlayerFallenAngel" in str(get_parent()):
		iconPlayer.texture = load("res://AllTextures/ForPlayer/Stats/Icons/iconFallenAngel.png")


func show_stats() -> void:
	stats.show()


func hide_stats() -> void:
	stats.hide()


func values_stats_to_default() -> void:
	for label in labelsNumberLocalCurrency:
		labelsNumberLocalCurrency[label].text = "0"
	
	for label in labelsAddLocalCurrency:
		labelsAddLocalCurrency[label].text = ""


func create_timer(waitTime) -> Timer:
	var timer = Timer.new()
	timer.wait_time = waitTime
	timer.one_shot = true
	add_child(timer)
	return timer


func add_currency(numberCurrencyFromPart, nameCurrency) -> void:
	if not animationAddCurrencyFinished[nameCurrency]:
		animationAddCurrencyFinished[nameCurrency] = true
		var timerAddCurrency = create_timer(0.1)
		timerAddCurrency.start()
		await timerAddCurrency.timeout
		timerAddCurrency.queue_free()
	
	var numberAddCurrency = numberCurrencyFromPart - int(labelsNumberLocalCurrency[nameCurrency].text)
	labelsAddLocalCurrency[nameCurrency].text = "+" + str(numberAddCurrency)
	
	var timerAlphaColor = create_timer(0.1)
	var alphaColor = 1
	animationAddCurrencyFinished[nameCurrency] = false
	
	while(alphaColor > 0):
		if animationAddCurrencyFinished[nameCurrency]:
			timerAlphaColor.queue_free()
			return
		alphaColor -= 0.05
		labelsAddLocalCurrency[nameCurrency].modulate = Color(Color.GREEN, alphaColor)
		timerAlphaColor.start()
		await timerAlphaColor.timeout
	
	animationAddCurrencyFinished[nameCurrency] = true
	timerAlphaColor.queue_free()
	
	labelsNumberLocalCurrency[nameCurrency].text = str(numberCurrencyFromPart)
	labelsAddLocalCurrency[nameCurrency].text = ""


func add_buff(nameSkill, timerDuration):
	var buff = TextureRect.new()
	buff.name = nameSkill
	buff.texture = load("res://AllTextures/ForPlayer/Stats/Buffs/" + nameSkill + ".png")
	get_node("CanvasLayer/Margins/Stats&Buffs/Buffs").add_child(buff)
	await timerDuration.timeout
	buff.queue_free()


func update_stats_currency(nameCurrency) -> void:
	if not ("Part" in str(get_parent().get_parent()) or "Farm" in str(get_parent().get_parent())):
		return
	
	if nameCurrency == "GoldCoins":
		add_currency(get_parent().get_parent().numberGoldCoins, "goldCoins")
	
	elif nameCurrency == "SilverCoins":
		add_currency(get_parent().get_parent().numberSilverCoins, "silverCoins")
	
	elif nameCurrency == "Keys":
		add_currency(get_parent().get_parent().numberKeys, "keys")


func update_global_stats_currency() -> void:
	if not ("Part" in str(get_parent().get_parent()) or "Farm" in str(get_parent().get_parent())):
		return
	
	labelsNumberGlobalCurrency["goldCoins"].text = str(GlobalPlayer.numberGoldCoins)
	labelsNumberGlobalCurrency["silverCoins"].text = str(GlobalPlayer.numberSilverCoins)
	labelsNumberGlobalCurrency["keys"].text = str(get_parent().get_parent().numberKeysFromGlobal)
