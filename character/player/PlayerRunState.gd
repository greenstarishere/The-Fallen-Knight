extends PlayerBase


# Called when the state machine enters this state.
func on_enter() -> void:
	pass

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	super(delta)
	animator.run(delta)
	if cameraPivot.cameraLock:
		if input_dir.y < 0 and input_dir.x == 0:
			animator.runForward(delta)
		elif input_dir.y > 0 and input_dir.x == 0:
			animator.runBackward(delta)
		elif input_dir.x < 0 and input_dir.y == 0:
			animator.strafeRunLeft(delta)
		elif input_dir.x > 0 and input_dir.y == 0:
			animator.strafeRunRight(delta)
		elif input_dir.x < 0 and input_dir.y < 0:
			animator.strafeRunForwardLeft(delta)
		elif input_dir.x > 0 and input_dir.y < 0:
			animator.strafeRunForwardRight(delta)
		elif input_dir.x < 0 and input_dir.y > 0:
			animator.strafeRunBackwardLeft(delta)
		elif input_dir.x > 0 and input_dir.y > 0:
			animator.strafeRunBackwardRight(delta)

# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	super(delta)

# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		change_state("Jump")

# Called when the state machine exits this state.
func on_exit() -> void:
	pass
