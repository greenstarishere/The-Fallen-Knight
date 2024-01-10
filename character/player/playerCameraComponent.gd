extends Node3D

@onready var player = $".."
@onready var animator: AnimationTree = %animationComponent
#camera
@onready var cameraArm = $armCamera
var sens_horizontal: float = 0.25
var sens_vertical: float = 0.25
#camera lock on
@onready var vision_range: Area3D = $visionRange
var lockTransition: float = 5.0
var cameraLock: bool = false 
var targetIndex: int
var targetList: Array
var activeTarget: Node3D

#shake
@export var trauma_reduction_rate := 1.0
@export var max_x := 10.0
@export var max_y := 10.0
@export var max_z := 5.0
@export var noise: FastNoiseLite
@export var noise_speed := 50.0
var trauma := 0.0
var time := 0.0
@onready var camera = $armCamera/Camera3D
@onready var initial_rotation := camera.rotation_degrees as Vector3

func _init():
	EventBus.connect("cameraShakeStart", add_trauma)
	EventBus.connect("toggleInput", toggleInput)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cameraLock:
		if Input.is_action_just_released("camera_cycles_down"):
			targetIndex = clampi(targetIndex + 1, 0, targetList.size() - 1)
		if Input.is_action_just_released("camera_cycles_up"):
			targetIndex = clampi(targetIndex - 1, 0, targetList.size() - 1)
		if !targetList.is_empty() and targetIndex < targetList.size():
			if is_instance_valid(targetList[targetIndex]):
				activeTarget = targetList[targetIndex]
			else:
				cameraLock = false
	#run when camera lock is true, get angle
	if cameraLock and is_instance_valid(activeTarget):
		animator.set("parameters/LockMode/transition_request", true)
		cameraArm.rotation.x = lerp_angle(cameraArm.rotation.x, deg_to_rad(-25), delta * lockTransition)
		rotation.y = lerp_angle(rotation.y, getAngleToTarget(), delta * lockTransition)
	else:
		animator.set("parameters/LockMode/transition_request", false)
	
	time += delta
	trauma = max(trauma - delta * trauma_reduction_rate, 0.0)
	camera.rotation_degrees.x = initial_rotation.x + max_x * get_shake_intensity() * get_noise_from_seed(0)
	camera.rotation_degrees.y = initial_rotation.y + max_y * get_shake_intensity() * get_noise_from_seed(1)
	camera.rotation_degrees.z = initial_rotation.z + max_z * get_shake_intensity() * get_noise_from_seed(2)

func add_trauma(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)

func _input(event: InputEvent) -> void:
	#run when camera lock is false
	if event is InputEventMouseMotion and !cameraLock and player.input:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		cameraArm.rotate_x(deg_to_rad(-event.relative.y * sens_vertical))
		cameraArm.rotation.x = clamp(cameraArm.rotation.x, deg_to_rad(-90), deg_to_rad(45))
	#flip flop camera lock mode
	if Input.is_action_just_pressed("camera_mode"):
		cameraLock = !cameraLock

func getAngleToTarget() -> float:
	if is_instance_valid(activeTarget):
		var target: Vector3 = -(activeTarget.global_position - global_position).normalized()
		var target_look: float = atan2(target.x, target.z)
		return target_look
	return 0

func _on_vision_range_area_entered(area: Area3D) -> void:
	getListOfTarget(area)

func _on_vision_range_area_exited(area: Area3D) -> void:
	getListOfTarget(area)
	if area == activeTarget:
		targetIndex = randi_range(0, targetList.size() - 1)

func getListOfTarget(area):
	if area.is_in_group("lockOnTarget"):
		var tempTarget: Array
		for overlappedArea in vision_range.get_overlapping_areas():
			if overlappedArea.is_in_group("lockOnTarget"):
				tempTarget.append(overlappedArea)
		targetList = tempTarget

func toggleInput(state: bool) -> void:
	if state:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
