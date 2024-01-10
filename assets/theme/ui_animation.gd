extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("showEnd", playEnd)

func playEnd():
	play("the_end")
