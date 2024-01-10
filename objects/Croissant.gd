extends Node3D

@onready var outline: MeshInstance3D = $mesh/outline

func _on_interactable_focused(interactor: Interactor) -> void:
	toggleOutline(true)

func _on_interactable_unfocused(interactor: Interactor) -> void:
	toggleOutline(false)

func _on_interactable_interacted(interactor: Interactor) -> void:
	EventBus.emit_signal("objectPickedUp", "croissant")
	queue_free()

func toggleOutline(cond: bool) -> void:
	if cond:
		outline.visible = cond
	else:
		outline.visible = cond
