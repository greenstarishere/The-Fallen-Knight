extends StateMachineState
class_name PlayerBase

@onready var player: CharacterBody3D = $"../.." as CharacterBody3D
@onready var skin: Node3D = %skin
@onready var animator: AnimationTree = %animationComponent
@onready var cameraPivot: Node3D = %pivotCamera
@onready var combo_timer: Timer = %ComboTimer

var canSwitchChar: bool = false
@onready var knight = %Knight
@onready var rogue = %Rogue
@onready var mage = %Mage
@onready var knight_animation_player = %knightAnimationPlayer
@onready var rogue_animation_player = %rogueAnimationPlayer
@onready var mage_animation_player = %mageAnimationPlayer


var charIndex: int
var input_dir: Vector2
var direction: Vector3
const LERP_SPEED: float = 5.0

# Called when the state machine enters this state.
func on_enter() -> void:
	pass

# Called every frame when this state is active.
func on_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta * 2
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	direction = direction.rotated(Vector3.UP, cameraPivot.rotation.y).normalized()
	
	#rotate skin
	if input_dir and !cameraPivot.cameraLock and player.input:
		skin.rotation.y = lerp_angle(skin.rotation.y, atan2(-direction.x, -direction.z), delta * LERP_SPEED)
	elif cameraPivot.cameraLock:
		skin.rotation.y = lerp_angle(skin.rotation.y, cameraPivot.getAngleToTarget(), delta * LERP_SPEED * 2)
	
	#apply velocity
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, delta * LERP_SPEED * 2)
		player.velocity.z = lerp(player.velocity.z, 0.0, delta * LERP_SPEED * 2)
	
	if (Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and Input.is_action_pressed("run") and player.input:
		player.SPEED = player.runSpeed
	elif (Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_backward") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and player.input:
		player.SPEED = player.walkSpeed
	else :
		player.SPEED = 0.0
	
	if player.SPEED > 2.0:
		change_state("Run")
	elif player.SPEED > 0.1:
		change_state("Walk")
	else:
		change_state("Idle")
		
	animator.on_ground(delta)

func charChanged(index):
	%changeCharTimer.start()
	if player.canChangeChar:
		match index:
			0:
				knight.visible = true
				rogue.visible = false
				mage.visible = false
				animator.anim_player = knight_animation_player.get_path()
			1:
				knight.visible = false
				rogue.visible = true
				mage.visible = false
				animator.anim_player = rogue_animation_player.get_path()
			2:
				knight.visible = false
				rogue.visible = false
				mage.visible = true
				animator.anim_player = mage_animation_player.get_path()
		%DynamicFlame.emitting = true
		player.canChangeChar = false
		EventBus.emit_signal("charChanged")

# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	player.move_and_slide()

# Called when there is an input event while this state is active.
func on_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and player.allow_attack:
		change_state("Attack")
	if Input.is_action_just_pressed("change_char") and player.canChangeChar:
		charIndex += 1
		if charIndex > 2:
			charIndex = 0
		charChanged(charIndex)

# Called when the state machine exits this state.
func on_exit() -> void:
	pass
