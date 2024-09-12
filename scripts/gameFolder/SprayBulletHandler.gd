extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const BOOGER_AREA = preload("res://scenes/boogers/booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var mutation_part_right = $"../mutationPartRight"
@onready var mutation_part_left = $"../mutationPartLeft"


@onready var auto_timer = $AutoTimer

var theta: float = 0.0
var firstResume: bool = true

func _ready():
	if Global.num_base_stars1 >= 1:
		auto_timer.start()
		auto_timer.wait_time = ((1.0 / (float(Global.num_base_stars1) + 1.0)) - 0.1) / Global.gameTimeScale

func _process(_delta):
	auto_timer.wait_time = ((1.0 / (float(Global.num_base_stars1) + 1.0)) - 0.1) / Global.gameTimeScale
	if Global.gameTimeScale < 0.1:
		auto_timer.stop()
		firstResume = true
	elif Global.num_base_stars1 >= 1 && firstResume:
		auto_timer.start()
		firstResume = false


func shootBall(mpart):
	var booger_area = BOOGER_AREA.instantiate()
	var shotparticles = SHOT_PARTICLES.instantiate()
	
	get_parent().add_child.call_deferred(booger_area)
	get_parent().add_child.call_deferred(shotparticles)
	var x: float = mpart.snoutPositionX()
	var y: float = mpart.snoutPositionY()
	
	var snout_length = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / snout_length)
	else:
		theta = 2 * PI -  acos(x / snout_length)
	
	booger_area.set_motion(x,y,theta,1)
	shotparticles.start_emit(x,y,theta)

func _on_auto_timer_timeout():
	shootBall(mutation_part_right)
	shootBall(mutation_part_left)
