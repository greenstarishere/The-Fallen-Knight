extends AnimationTree

var weight: float = 5

# Called when the node enters the scene tree for the first time.
func idle(delta) -> void:
	set("parameters/movement/blend_amount", lerp(get("parameters/movement/blend_amount"), -1.0, delta*weight))
	
func walk(delta) -> void:
	set("parameters/movement/blend_amount", lerp(get("parameters/movement/blend_amount"), 0.0, delta*weight))

func run(delta) -> void:
	set("parameters/movement/blend_amount", lerp(get("parameters/movement/blend_amount"), 1.0, delta*weight))

func on_ground(delta) -> void:
	set("parameters/on_air/blend_amount", lerp(get("parameters/on_air/blend_amount"), 0.0, delta*weight))

func on_air(delta) -> void:
	set("parameters/on_air/blend_amount", lerp(get("parameters/on_air/blend_amount"), 1.0, delta*weight))

func block(condition: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "parameters/blocking/blend_amount", condition, 0.1)

func attack(index: int):
	set("parameters/attack/transition_request", "attack_"+str(index))

func pickUp():
	set("parameters/pickUp/transition_request", "pick_up")





#root lock is true
func lockIdle(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, 0,0)
	#walk
		#forward
func walkForward(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, 0,0.5)
func strafeWalkForwardLeft(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, -0.5,0.5)
func strafeWalkForwardRight(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, 0.5,0.5)
		#neutral
func strafeWalkLeft(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, -0.5,0)
func strafeWalkRight(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, 0.5,0)
		#backward
func walkBackward(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, 0,-1)
func strafeWalkBackwardLeft(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, -1,-1)
func strafeWalkBackwardRight(delta):
	set("parameters/rootLockSpeed/scale", 0.5)
	setRootLockVector(delta, 1,-1)
	
	#run
		#forward
func runForward(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, 0,1)
func strafeRunForwardLeft(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, -1,0)
func strafeRunForwardRight(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, 1,0)
		#neutral
func strafeRunLeft(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, -1,0)
func strafeRunRight(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, 1,0)
		#backward
func runBackward(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, 0,-1)
func strafeRunBackwardLeft(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, -1,-1)
func strafeRunBackwardRight(delta):
	set("parameters/rootLockSpeed/scale", 1)
	setRootLockVector(delta, 1,-1)


func setRootLockVector(delta: float, x: float, y: float):
	set("parameters/rootLock/blend_position", lerp(get("parameters/rootLock/blend_position"), Vector2(x,y), delta * weight))
