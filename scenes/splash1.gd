extends VideoStreamPlayer

var is_active := true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("finished")
