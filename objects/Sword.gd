extends Node3D

@onready var outline = $sword/outline

func _on_interactable_focused(interactor):
	toggleOutline(true)

func _on_interactable_unfocused(interactor):
	toggleOutline(false)

func _on_interactable_interacted(interactor):
	EventBus.emit_signal("swordPickedUp")
	queue_free()

func toggleOutline(cond: bool) -> void:
	if cond:
		outline.visible = cond
	else:
		outline.visible = cond
