extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const BOOGER_AREA = preload("res://scenes/boogers/booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var spray = $"../Spray"


@onready var auto_timer = $AutoTimer

var theta: float = 0.0
var firstResume: bool = true

var thrusting: bool = false

var leftNow: bool = true

func _process(_delta):
	if Global.startCrasher == false && Global.crashStarted == true:
		auto_timer.start()
		if Global.gameTimeScale < 0.1:
			#auto_timer.stop()
			firstResume = true
		elif firstResume:
			#auto_timer.start()
			firstResume = false
	else:
		auto_timer.stop()

@onready var wacky_l = $"../Spray/WackyL"
@onready var wacky_r = $"../Spray/WackyR"

func shootBall():
	var booger_area = BOOGER_AREA.instantiate()
	
	get_parent().add_child.call_deferred(booger_area)
	var default_x: float = spray.position.x
	var default_y: float = spray.position.y
	
	
	
	var snout_length = sqrt((74 * 74) + (110 * 110))
	
	#if spray.rotation >= 0
	theta = (-spray.rotation) + (PI/2)
	
	
	booger_area.mod_scale(Vector2(0.1,0.1))
	
	booger_area.SPEED = 5000.0
	
	if leftNow:
		booger_area.set_motion(wacky_l.global_position.x,wacky_l.global_position.y,theta - PI - 0.6 + randf_range(-0.2,0.2),1)
		leftNow = false
	else:
		booger_area.set_motion(wacky_r.global_position.x,wacky_r.global_position.y,theta - PI + 0.6 + randf_range(-0.2,0.2),1)
		leftNow = true

func _on_auto_timer_timeout():
	if thrusting:
		shootBall()
