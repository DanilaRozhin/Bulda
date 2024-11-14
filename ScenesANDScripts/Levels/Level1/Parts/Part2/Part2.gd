extends BasePart

@onready var areas = {
	"midPart" : $Areas/AreaMidPart,
	"nextPart" : $Areas/AreaNextPart
}



func _ready():
	player = $PlayerFallenAngel
	super._ready()



func _on_area_next_part_body_entered(body):
	if "Player" in body.name:
		areas["nextPart"].queue_free()
		next_part("res://ScenesANDScripts/Levels/Level1/Parts/Part3/LoadingScreenPart3.tscn")


func _on_area_mid_part_body_entered(body):
	if "Player" in body.name:
		areas["midPart"].queue_free()
		body.set_information("Чёрт, не разбиться бы...")
