extends VideoStreamPlayer

var is_active := false

func _input(event: InputEvent) -> void:
	if is_active:
		if Input.is_action_just_pressed("ui_cancel"):
			emit_signal("finished")
