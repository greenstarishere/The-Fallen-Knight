extends Area3D
class_name Interactor

var controller: Node3D

@export var player: CharacterBody3D
var cached_closest: Interactable

func ready() -> void:
	controller = player

func _physics_process(_delta) -> void:
	var new_closest: Interactable = get_closest_interactable()
	if new_closest != cached_closest:
		if is_instance_valid(cached_closest):
			unfocus(cached_closest)
		if new_closest:
			focus(new_closest)
		cached_closest = new_closest

func _input(event) -> void:
	if event.is_action_pressed("interact"):
		if is_instance_valid(cached_closest):
			interact(cached_closest)

func _on_area_exited(area: Area3D) -> void:
	if cached_closest == area:
		unfocus(area)


func focus(interactable: Interactable) -> void:
	interactable.focused.emit(self)
	
func unfocus(interactable: Interactable) -> void:
	interactable.unfocused.emit(self)
	
func interact(interactable: Interactable) -> void:
	interactable.interacted.emit(self)

func get_closest_interactable() -> Interactable:
	var list: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance: float = INF
	var closest: Interactable = null
	
	for interactable in list:
		distance = interactable.global_position.distance_to(global_position)
		if distance < closest_distance:
			closest = interactable as Interactable
			closest_distance = distance
	return closest

