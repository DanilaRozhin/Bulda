extends BasePart

@onready var areas = {
	"legs" : $Areas/AreaLegs,
	"arms" : $Areas/AreaArms,
	"sword" : $Areas/AreaSword,
	"shield" : $Areas/AreaShield,
	"helmet" : $Areas/AreaHelmet,
	"armor" : $Areas/AreaArmor,
	
	"nextPart" : $Areas/AreaNextPart,
	"checkFullSet" : $Areas/AreaCheckSet,
	"entryRuins" : $Areas/AreaEntryRuins,
	"exitRuins" : $Areas/AreaExitRuins
}

@onready var items = {
	"legs" : $CollectableObjects/Legs,
	"arms" : $CollectableObjects/Arms,
	"sword" : $CollectableObjects/Sword,
	"shield" : $CollectableObjects/Shield,
	"helmet" : $CollectableObjects/Helmet,
	"armor" : $CollectableObjects/Armor
}

var collectItems = {
	"legs" : false,
	"arms" : false,
	"sword" : false,
	"shield" : false,
	"helmet" : false,
	"armor" : false
}


func _ready():
	player = $PlayerFallenAngel
	super._ready()
	areas["nextPart"].set_deferred("monitoring", false)
	player.set_information("Вот и руины. Нужно быть осторожным, кто знает, что там впереди")



func collect_item(body, nameItem, info) -> void:
	if not "Player" in body.name:
		return
	
	areas[nameItem].queue_free()
	items[nameItem].queue_free()
	collectItems[nameItem] = true
	body.set_information(info)
	
	if nameItem == "sword":
		body.sounds["pickUPSword"].play()
		return
	
	body.sounds["pickUPArmor"].play()



func _on_area_next_part_body_entered(body):
	if "Player" in body.name:
		areas["nextPart"].queue_free()
		next_part("res://ScenesANDScripts/Levels/Level1/Parts/Part4/LoadingScreenPart4.tscn")


func _on_area_legs_body_entered(body):
	collect_item(body, "legs", "Хм, похоже, это обувь от какого-то доспеха. Может здесь получится найти и другие его части?")


func _on_area_arms_body_entered(body):
	collect_item(body, "arms", "Это похоже на наручи от того же доспеха, что и обувь")


func _on_area_sword_body_entered(body):
	collect_item(body, "sword", "Меч? Отлично, он будет получше моей палки")


func _on_area_shield_body_entered(body):
	collect_item(body, "shield", "Этот щит явно не будет лишним")


func _on_area_helmet_body_entered(body):
	collect_item(body, "helmet", "А вот и шлем из той легенды")


func _on_area_armor_body_entered(body):
	collect_item(body, "armor", "Будем надеяться, что я в него влезу")


func _on_area_check_set_body_entered(body):
	if not "Player" in body.name:
		return
	
	for item in collectItems:
		if collectItems[item] == false:
			body.set_information("Я нашёл не весь доспех. Я думаю, мне стоит вернуться, иначе мне нечем драться с разбойниками")
			return
	
	areas["checkFullSet"].queue_free()
	areas["nextPart"].set_deferred("monitoring", true)
	body.set_information("Вот и всё: легенда стала явью. Теперь разбойникам можно дать отпор")


func _on_area_entry_ruins_body_entered(body):
	if "Player" in body.name:
		areas["entryRuins"].queue_free()
		body.set_information("Мда... Сюда явно не ступала человеческая нога. Уверен, здесь есть, чем поживиться")


func _on_area_exit_ruins_body_entered(body):
	if "Player" in body.name:
		areas["exitRuins"].queue_free()
		body.set_information("Пора возвращаться домой")
