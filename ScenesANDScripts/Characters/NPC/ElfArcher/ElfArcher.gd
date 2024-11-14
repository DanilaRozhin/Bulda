extends BaseNPC



func run() -> void:
	velocity.x = -SPEED
	animation["parameters/conditions/run"] = true
	animation["parameters/conditions/idle"] = false


func start_dialog(dPath1, dPath2) -> void:
	if not dialog.dialogStarted and not firstDialogFinished:
		dialog.start_dialog(dPath1)
	
	elif not dialog.dialogStarted and firstDialogFinished:
		dialog.start_dialog(dPath2)
		GlobalLevel.dialogWithElfArcherCompleted = "true"
	
	elif dialog.dialogStarted:
		dialog.continue_dialog()
