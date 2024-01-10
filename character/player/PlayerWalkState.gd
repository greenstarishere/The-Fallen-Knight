extends PlayerBase

var footstep_interval: float = 0.3

# Called when the state machine enters this state.
func on_enter() -> void:
	pass

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	super(delta)
	animator.walk(delta)
	if cameraPivot.cameraLock:
		if input_dir.y < 0 and input_dir.x == 0:
			animator.walkForward(delta)
		elif input_dir.y > 0 and input_dir.x == 0:
			animator.walkBackward(delta)
		elif input_dir.x < 0 and input_dir.y == 0:
			animator.strafeWalkLeft(delta)
		elif input_dir.x > 0 and input_dir.y == 0:
			animator.strafeWalkRight(delta)
		elif input_dir.x < 0 and input_dir.y < 0:
			animator.strafeWalkForwardLeft(delta)
		elif input_dir.x > 0 and input_dir.y < 0:
			animator.strafeWalkForwardRight(delta)
		elif input_dir.x < 0 and input_dir.y > 0:
			animator.strafeWalkBackwardLeft(delta)
		elif input_dir.x > 0 and input_dir.y > 0:
			animator.strafeWalkBackwardRight(delta)

# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	super(delta)

# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		change_state("Jump")
	if Input.is_action_pressed("block"):
		change_state("Block")


# Called when the state machine exits this state.
func on_exit() -> void:
	pass
