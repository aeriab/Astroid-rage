extends Node

const BOOGER_AREA = preload("res://scenes/boogers/spray_booger.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var spray = $"../Spray"


@onready var auto_timer = $AutoTimer1
@onready var auto_timer_2 = $AutoTimer2


var theta: float = 0.0
var firstResume: bool = true

var thrusting: bool = false

var leftNow: bool = true

var turningLeft: int = -1

var firstTimerTurn: bool = true


func _ready():
	auto_timer.wait_time = 0.075 - (Global.num_drone_stars1 * 0.01)
	auto_timer_2.wait_time = 0.15 - (Global.num_drone_stars1 * 0.02)


func _process(_delta):
	
	if Global.startCrasher == false && Global.crashStarted == true && firstTimerTurn:
		
		auto_timer.start()
		auto_timer_2.start()
		firstTimerTurn = false
	
	if !Global.startCrasher and !Global.crashStarted:
		firstTimerTurn = true

@onready var wacky_l = $"../Spray/WackyL"
@onready var wacky_r = $"../Spray/WackyR"

func shootBall():
	var booger_area = BOOGER_AREA.instantiate()
	get_parent().add_child.call_deferred(booger_area)
	theta = (-spray.rotation) + (PI/2)
	
	booger_area.mod_scale(Vector2(0.1,0.1))
	
	booger_area.SPEED = 3000.0
	
	if leftNow:
		Global.prior_dir = -1
		booger_area.set_motion(wacky_l.global_position.x,wacky_l.global_position.y,theta - PI - 0.6 + randf_range(-0.2,0.2),1)
		leftNow = false
	else:
		Global.prior_dir = 1
		booger_area.set_motion(wacky_r.global_position.x,wacky_r.global_position.y,theta - PI + 0.6 + randf_range(-0.2,0.2),1)
		leftNow = true

@onready var turn_l = $"../Spray/TurnL"
@onready var turn_r = $"../Spray/TurnR"

func shootLeft():
	var booger_area = BOOGER_AREA.instantiate()
	get_parent().add_child.call_deferred(booger_area)
	theta = (-spray.rotation) + (PI/2)
	booger_area.mod_scale(Vector2(0.1,0.1))
	booger_area.SPEED = 4000.0
	booger_area.set_motion(turn_l.global_position.x,turn_l.global_position.y,theta - PI - 1.6 + randf_range(-0.2,0.2),1)

func shootRight():
	var booger_area = BOOGER_AREA.instantiate()
	get_parent().add_child.call_deferred(booger_area)
	theta = (-spray.rotation) + (PI/2)
	booger_area.mod_scale(Vector2(0.1,0.1))
	booger_area.SPEED = 4000.0
	booger_area.set_motion(turn_r.global_position.x,turn_r.global_position.y,theta - PI + 1.6 + randf_range(-0.2,0.2),1)


func _on_auto_timer_timeout():
	if thrusting:
		shootBall()
	
	if Global.startCrasher == false && Global.crashStarted == true:
		auto_timer.start()
	else:
		auto_timer.stop()


func _on_auto_timer_2_timeout():
	if turningLeft == 1:
		shootLeft()
	elif turningLeft == 0:
		shootRight()
	
	if Global.startCrasher == false && Global.crashStarted == true:
		auto_timer_2.start()
	else:
		auto_timer_2.stop()
