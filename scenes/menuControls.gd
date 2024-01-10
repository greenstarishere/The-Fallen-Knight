extends Control

@onready var settings_panel: AspectRatioContainer = $SettingsPanel
@onready var game = preload("res://scenes/main.tscn")
var pop: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_settings_pressed() -> void:
	settings_panel.visible = true
	settings_panel.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_about_us_pressed() -> void:
	if !pop:
		$cards/AnimationPlayer.play("pop")
		pop = true
	else:
		$cards/AnimationPlayer.play_backwards("pop")
		pop = false

func _on_start_pressed() -> void:
	SceneTransition.change_scene(game)

func _on_res_option_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2(1920.0,1080.0))
		1:
			DisplayServer.window_set_size(Vector2(1280.0,720.0))

func _on_screen_option_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_lang_option_item_selected(index: int) -> void:
	match index:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("id")
		2:
			TranslationServer.set_locale("jp")

func _on_exit_button_pressed() -> void:
	settings_panel.visible = false
	settings_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
