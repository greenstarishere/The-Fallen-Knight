extends Panel

@onready var menu: Node3D = $"../.."

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if (event is InputEventMouseMotion) and (event is InputEventMouseButton):
			print("clicked")
			menu.pivotMove = true
			menu.pivot_camera.rotate_y(deg_to_rad(-event.relative.x * 5))
		else:
			menu.pivotMove = false
	else:
		menu.pivotMove = false
