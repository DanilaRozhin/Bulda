extends BasePart

@onready var NPC = {
	"elfArcher" : $NPC/ElfArcher,
	"womanFallenAngel" : $NPC/WomanFallenAngel,
	"kingFallenAngel" : $NPC/KingFallenAngel
}

@onready var areas = {
	"diedCitizens" : $Areas/AreaDiedCitizens,
	"deadWoman" : $Areas/AreaDeadWoman,
	"deadOwner" : $Areas/AreaDeadOwner,
	"destroyedHouses" : $Areas/AreaDestroyedHouses,
	"houseAlcoholic" : $Areas/AreaHouseAlcoholic,
	
	"runningElfArcher" : $Areas/AreaRunningElfArcher,
	"deleteElfArcher" : $Areas/AreaDeleteElfArcher,
	
	"nextPart" : $Areas/AreaNextPart
}



func _ready():
	player = $PlayerKnight
	super._ready()
	
	player.set_information("Какого чёрта здесь произошло...")
	
	NPC["womanFallenAngel"].die()
	NPC["kingFallenAngel"].die()
	
	NPC["elfArcher"].set_information("ДРАПАЕМ!")
	NPC["elfArcher"].run()



func character_opinion(body, nameArea, info) -> void:
	if "Player" in body.name:
		areas[nameArea].queue_free()
		body.set_information(info)



func _on_area_next_part_body_entered(body):
	if "Player" in body.name:
		areas["nextPart"].queue_free()
		next_part("res://ScenesANDScripts/Levels/Epilogue/Epilogue.tscn")


func _on_area_delete_elf_archer_body_entered(body):
	if "ElfArcher" in body.name:
		areas["deleteElfArcher"].queue_free()
		NPC["elfArcher"].queue_free()


func _on_area_died_citizens_body_entered(body):
	character_opinion(body, "diedCitizens", "Они их просто убивают... Я обязан что-то с этим сделать!")


func _on_area_dead_woman_body_entered(body):
	character_opinion(body, "deadWoman", "Буду честен, её мне не сильно жалко...")


func _on_area_dead_owner_body_entered(body):
	character_opinion(body, "deadOwner", "А ведь он был мне как отец...")


func _on_area_running_elf_archer_body_entered(body):
	character_opinion(body, "runningElfArcher", "Кто бы сомневался, что ты сбежишь...")


func _on_area_destroyed_houses_body_entered(body):
	character_opinion(body, "destroyedHouses", "Даже колодец...")


func _on_area_house_alcoholic_body_entered(body):
	character_opinion(body, "houseAlcoholic", "Видимо поэтому ты и не любил гостей...")
