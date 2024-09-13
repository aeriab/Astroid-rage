extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const BOOGER_AREA = preload("res://scenes/boogers/booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var spray = $"../Spray"


@onready var auto_timer = $AutoTimer

var theta: float = 0.0
var firstResume: bool = true

var thrusting: bool = false

func _process(_delta):
	if Global.startCrasher == false && Global.crashStarted == true:
		if Global.gameTimeScale < 0.1:
			auto_timer.stop()
			firstResume = true
		elif firstResume:
			auto_timer.start()
			firstResume = false

@onready var wacky = $"../Spray/Wacky"

func shootBall():
	var booger_area = BOOGER_AREA.instantiate()
	
	get_parent().add_child.call_deferred(booger_area)
	var default_x: float = spray.position.x
	var default_y: float = spray.position.y
	
	
	
	var snout_length = sqrt((74 * 74) + (110 * 110))
	
	#if spray.rotation >= 0
	theta = (-spray.rotation) + (PI/2)
	
	
	booger_area.mod_scale(Vector2(0.1,0.1))
	
	booger_area.set_motion(wacky.global_position.x,wacky.global_position.y,theta - PI,1)

func _on_auto_timer_timeout():
	if thrusting:
		shootBall()
