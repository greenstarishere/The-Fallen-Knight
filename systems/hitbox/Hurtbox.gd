extends Area3D
class_name Hurtbox

func _init():
	collision_layer = 0
	collision_mask = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	
