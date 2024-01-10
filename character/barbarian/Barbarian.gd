extends CharacterBody3D

var npc: String = "barbarian"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		Dialogic.timeline_ended.connect(endDialog)
		Dialogic.start(npc + "_" +str(body.phase))
		EventBus.emit_signal("toggleInput", false)

func endDialog():
	Dialogic.timeline_ended.disconnect(endDialog)
	EventBus.emit_signal("toggleInput", true)
