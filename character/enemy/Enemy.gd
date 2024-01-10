extends CharacterBody3D

@onready var dummy_body = %Dummy_Body
@onready var animation_player = $AnimationPlayer
var health: float = 90
var is_shaking: bool = false
var rotate_value: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	rotate_value = lerpf(rotate_value, 0, delta * 5)
	dummy_body.rotate_y(deg_to_rad(rotate_value))

func take_damage(damage):
	if health < 0:
		Engine.time_scale = 0.07
		animation_player.play("dead")
		EventBus.emit_signal("enemyDead")
		EventBus.emit_signal("cameraShakeStart", 1)
		await get_tree().create_timer(0.07 * 0.45).timeout
		Engine.time_scale = 1.0
		await animation_player.animation_finished
		queue_free()
	else:
		Engine.time_scale = 0.07
		health -= damage
		rotate_value = 20
		animation_player.play("hit")
		EventBus.emit_signal("enemyHit")
		EventBus.emit_signal("cameraShakeStart", 0.6)
		await get_tree().create_timer(0.07 * 0.3).timeout
		Engine.time_scale = 1.0
