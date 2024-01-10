extends Area3D
class_name Hitbox

@export var damage: float = 20

func _init():
	collision_layer = 4
	collision_mask = 0
