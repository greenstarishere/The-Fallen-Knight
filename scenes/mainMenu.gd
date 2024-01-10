extends Node3D

@onready var pivot_camera: Node3D = $pivotCamera
@onready var splash_1: VideoStreamPlayer = $AspectRatioContainer/splash1
@onready var splash_2: VideoStreamPlayer = $AspectRatioContainer/splash2
@onready var aspect_ratio_container: AspectRatioContainer = $AspectRatioContainer

var pivotMove: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !pivotMove:
		pivot_camera.rotation.y += deg_to_rad(0.1)

func _on_splash_1_finished() -> void:
	if splash_1.is_active:
		splash_2.is_active = true
		splash_1.queue_free()
		splash_2.play()


func _on_splash_2_finished() -> void:
	if splash_2.is_active:
		splash_2.queue_free()
		aspect_ratio_container.queue_free()
