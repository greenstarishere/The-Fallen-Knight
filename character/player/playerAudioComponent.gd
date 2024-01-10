extends Node

var impact: Array = []
@onready var impact_dead = $impact_dead

# Called when the node enters the scene tree for the first time.
func _ready():
	impact = [$impact_1, $impact_2, $impact_3, $impact_4]
	EventBus.connect("enemyHit", enemyHit)
	EventBus.connect("enemyDead", enemyDead)

func enemyHit():
	impact.pick_random().play()

func enemyDead():
	impact[3].play()
	impact_dead.play()
