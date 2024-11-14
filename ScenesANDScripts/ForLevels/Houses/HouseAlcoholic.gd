extends StaticBody2D


@onready var spriteHouse = $SpriteHouse
@onready var spriteAlcoholic = $SpriteAlcoholic

@onready var areaKnockDoor = $AreaKnockDoor

@onready var speechAlcoholic = $SpeechAlcoholic


var canAlcoholicSpeak = true
var playerInAreaKnockDoor = false



func _ready():
	spriteHouse.hide()
	spriteAlcoholic.hide()



func speech_alcoholic() -> void:
	if not playerInAreaKnockDoor or not canAlcoholicSpeak:
		return

	canAlcoholicSpeak = false
	spriteAlcoholic.show()
	speechAlcoholic.volume_db = GlobalSettings.volumeSounds
	speechAlcoholic.play()



func _on_area_knock_door_body_entered(body):
	if "Player" in body.name:
		body.canKnockDoor = true
		body.show_button_action()
		playerInAreaKnockDoor = true


func _on_area_knock_door_body_exited(body):
	if "Player" in body.name:
		body.canKnockDoor = false
		body.hide_button_action()
		playerInAreaKnockDoor = false


func _on_visible_on_screen_enabler_screen_entered():
	spriteHouse.show()


func _on_visible_on_screen_enabler_screen_exited():
	spriteHouse.hide()


func _on_speech_alcoholic_finished():
	spriteAlcoholic.hide()
	canAlcoholicSpeak = true
