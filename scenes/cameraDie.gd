extends Camera3D

var finalPosition: Vector3
var changePosition: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("playerDead", changeTransfrom)
	finalPosition = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if changePosition:
		global_position = lerp(global_position, finalPosition, delta * 5)

func changeTransfrom(targetPosition) -> void:
	global_position = targetPosition
	changePosition = true
