extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_card_pic_mouse_entered() -> void:
	animation_player.play_backwards("pop_1")

func _on_card_pic_2_mouse_entered() -> void:
	animation_player.play_backwards("pop_2")

func _on_card_pic_3_mouse_entered() -> void:
	animation_player.play_backwards("pop_3")
