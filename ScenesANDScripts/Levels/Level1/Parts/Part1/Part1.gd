extends BasePart

@onready var NPC = {
	"sellerArmor" : $NPC/SellerArmor,
	"elfArcher" : $NPC/ElfArcher,
	"womanFallenAngel" : $NPC/WomanFallenAngel,
	"kingFallenAngel" : $NPC/KingFallenAngel
}

@onready var areas = {
	"sellerArmor" : $Areas/AreaSellerArmor,
	"elfArcher" : $Areas/AreaElfArcher,
	"womanFallenAngel" : $Areas/AreaWomanFallenAngel,
	"kingFallenAngel" : $Areas/AreaKingFallenAngel,
	"nextPart" : $Areas/AreaNextPart
}



func _ready():
	player = $PlayerFallenAngel
	super._ready()



func start_dialog(body, nameNPC, pathDialog1, pathDialog2) -> void:
	if "Player" in body.name:
		body.show_button_action()
		NPC[nameNPC].start_dialog(pathDialog1, pathDialog2)


func stop_dialog(body, nameNPC) -> void:
	if "Player" in body.name:
		body.hide_button_action()
		NPC[nameNPC].stop_dialog()



func _on_area_next_part_body_entered(body):
	if "Player" in body.name:
		areas["nextPart"].queue_free()
		GlobalLevel.save_data()
		next_part("res://ScenesANDScripts/Levels/Level1/Parts/Part2/LoadingScreenPart2.tscn")


func _on_area_seller_armor_body_entered(body):
	start_dialog(body, "sellerArmor", "res://ScenesANDScripts/Characters/Sellers/SellerArmor/Dialog1.json", "res://ScenesANDScripts/Characters/Sellers/SellerArmor/Dialog2.json")


func _on_area_seller_armor_body_exited(body):
	stop_dialog(body, "sellerArmor")


func _on_area_elf_archer_body_entered(body):
	start_dialog(body, "elfArcher", "res://ScenesANDScripts/Characters/NPC/ElfArcher/Dialog1.json", "res://ScenesANDScripts/Characters/NPC/ElfArcher/Dialog2.json")


func _on_area_elf_archer_body_exited(body):
	stop_dialog(body, "elfArcher")


func _on_area_woman_fallen_angel_body_entered(body):
	start_dialog(body, "womanFallenAngel", "res://ScenesANDScripts/Characters/NPC/WomanFallenAngel/Dialog1.json", "res://ScenesANDScripts/Characters/NPC/WomanFallenAngel/Dialog2.json")


func _on_area_woman_fallen_angel_body_exited(body):
	stop_dialog(body, "womanFallenAngel")


func _on_area_king_fallen_angel_body_entered(body):
	start_dialog(body, "kingFallenAngel", "res://ScenesANDScripts/Characters/NPC/KingFallenAngel/Dialog1.json", "res://ScenesANDScripts/Characters/NPC/KingFallenAngel/Dialog2.json")


func _on_area_king_fallen_angel_body_exited(body):
	stop_dialog(body, "kingFallenAngel")
