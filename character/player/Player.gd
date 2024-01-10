extends CharacterBody3D

var SPEED: float = 5.0
const JUMP_VELOCITY = 8

@export var runSpeed: float = 6.0
@export var walkSpeed: float = 1.3
@onready var camera_3d: Camera3D = $pivotCamera/armCamera/Camera3D
@onready var sword: BoneAttachment3D = $"skin/Knight/Rig/Skeleton3D/1H_Sword"
@onready var animator: AnimationTree = %animationComponent
@onready var main_menu: Button = $"../User Interface/mainMenu"

var canChangeChar: bool = true
var croissant: int = 0
var input: bool = true
var phase: int = 0
var allow_attack: bool = false
var attackIndex: int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	EventBus.connect("objectPickedUp", objectPickUp)
	EventBus.connect("swordPickedUp", toggleSword)
	EventBus.connect("toggleInput", toggleInput)
	EventBus.connect("addDialogPhase", addPhase)
	Dialogic.connect("signal_event", signalHandler)

func die() -> void :
	EventBus.emit_signal("playerDead", camera_3d.global_position)
	queue_free()
	EventBus.emit_signal("toggleInput", false)
	main_menu.visible = true
	

func toggleInput(state) -> void:
	input = state

func addPhase() -> void:
	phase += 1
	if phase == 1:
		$"../Enemy".visible = true
		$"../Sword".visible = true

func signalHandler(signalNames) -> void:
	if signalNames == "advancePhase":
		addPhase()

func toggleSword() -> void:
	animator.pickUp()
	await animator.animation_finished
	allow_attack = true
	sword.visible = true

func objectPickUp(object: String):
	if object == "croissant":
		animator.pickUp()
		await animator.animation_finished
		croissant += 1
		Dialogic.VAR.croissants = croissant


func _on_change_char_timer_timeout() -> void:
	canChangeChar = true
