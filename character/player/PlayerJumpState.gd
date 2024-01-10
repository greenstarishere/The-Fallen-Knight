extends PlayerBase


# Called when the state machine enters this state.
func on_enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta * 2
	else:
		change_state("Idle")
	
	direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	player.velocity.x = lerp(player.velocity.x, 0.0, delta )
	player.velocity.z = lerp(player.velocity.z, 0.0, delta )
	
	animator.on_air(delta)

# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	super(delta)

# Called when there is an input event while this state is active.
func on_input(_event: InputEvent) -> void:
	pass

# Called when the state machine exits this state.
func on_exit() -> void:
	pass
