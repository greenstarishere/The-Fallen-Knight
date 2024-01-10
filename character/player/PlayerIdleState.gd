extends PlayerBase


# Called when the state machine enters this state.
func on_enter() -> void:
	canSwitchChar = true

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	super(delta)
	animator.idle(delta)
	if cameraPivot.cameraLock:
		animator.lockIdle(delta)


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	super(delta)


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	super(event)
	if Input.is_action_pressed("jump") and player.is_on_floor():
		change_state("Jump")
	if Input.is_action_pressed("block"):
		change_state("Block")


# Called when the state machine exits this state.
func on_exit() -> void:
	canSwitchChar = false

func _on_combo_timer_timeout() -> void:
	player.attackIndex = 0
