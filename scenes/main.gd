extends Node3D

@onready var prologue_video: AspectRatioContainer = $prologueVideo
@onready var animation_player: AnimationPlayer = $prologueVideo/AnimationPlayer
@onready var prologue: VideoStreamPlayer = $prologueVideo/prologue

func _ready() -> void:
	await get_tree().create_timer(50.0).timeout
	animation_player.play("fade")

func _on_prologue_finished() -> void:
	prologue.queue_free()
	prologue_video.queue_free()
	Dialogic.start("timeline")

func _on_main_menu_pressed() -> void:
	SceneTransition.change_scene_to_file("res://scenes/main_menu.tscn")
