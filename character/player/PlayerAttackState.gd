extends PlayerBase

var move_to
@onready var sword_collision = %SwordCollision
@onready var whoosh = %whoosh

# Called when the state machine enters this state.
func on_enter() -> void:
	move_to = Vector3(0,0,-1).rotated(Vector3.UP, cameraPivot.rotation.y).normalized()
	if player.allow_attack:
		whoosh.play()
		combo_timer.start()
		player.attackIndex = player.attackIndex + 1
		player.allow_attack = false
		animator.attack(player.attackIndex)
		await get_tree().create_timer(0.35).timeout
		sword_collision.set_disabled(false)
		if player.attackIndex == 5:
			whoosh.play()
			await get_tree().create_timer(0.35).timeout
			sword_collision.set_disabled(true)
			sword_collision.set_disabled(false)
			await animator.animation_finished
			player.attackIndex = 0
			change_state("Idle")
		await get_tree().create_timer(0.35).timeout
		player.allow_attack = true
		change_state("Idle")

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, move_to.x * 2, delta * LERP_SPEED)
	player.velocity.z = lerp(player.velocity.z, move_to.z * 2, delta * LERP_SPEED)
	skin.rotation.y =  lerp_angle(skin.rotation.y, atan2(-move_to.x, -move_to.z), delta * LERP_SPEED * 2)
# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	super(delta)


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	super(event)


# Called when the state machine exits this state.
func on_exit() -> void:
	animator.attack(0)
	sword_collision.set_disabled(true)
