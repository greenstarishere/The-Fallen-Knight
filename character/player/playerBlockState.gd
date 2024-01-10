extends PlayerBase


# Called when the state machine enters this state.
func on_enter() -> void:
	animator.block(1.0)


# Called every frame when this state is active.
func on_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta * 2
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction = direction.rotated(Vector3.UP, cameraPivot.rotation.y).normalized()
	
	if input_dir:
		skin.rotation.y = lerp_angle(skin.rotation.y, atan2(direction.x, direction.z), delta * LERP_SPEED)
	
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
		animator.walk(delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, delta * LERP_SPEED * 2)
		player.velocity.z = lerp(player.velocity.z, 0.0, delta * LERP_SPEED * 2)
		animator.idle(delta)
	

# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	super(delta)


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	if Input.is_action_just_released("block"):
		change_state("Idle")


# Called when the state machine exits this state.
func on_exit() -> void:
	animator.block(0.0)

