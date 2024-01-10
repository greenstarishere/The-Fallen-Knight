extends Area3D

var endGame: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.connect("signal_event", signalHandler)

func signalHandler(signalNames) -> void:
	if signalNames == "endGame":
		endGame = true

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		if !endGame:
			body.die()
			%die.visible = true
		else:
			body.die()
			%die.visible = true
			EventBus.emit_signal("showEnd")
			$"../../User Interface/The End".visible = true
