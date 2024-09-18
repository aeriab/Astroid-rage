extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var mutation_part = $"../Player/mutationPart"

@onready var auto_timer = $AutoTimer
var firstResume: bool = true

var theta: float = 0.0

func _ready():
	if Global.num_base_stars1 >= 1:
		auto_timer.start()
		auto_timer.wait_time = (0.5 / (float(Global.num_base_stars1) + 1.0)) / Global.gameTimeScale

func _process(_delta):
	auto_timer.wait_time = (0.5 / (float(Global.num_base_stars1) + 1.0)) / Global.gameTimeScale
	if Global.gameTimeScale < 0.1:
		auto_timer.stop()
		firstResume = true
	elif Global.num_base_stars1 >= 1 && firstResume:
		auto_timer.start()
		firstResume = false
	
	if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		var ricoball = RICO_BALL.instantiate()
		var shotparticles = SHOT_PARTICLES.instantiate()
		
		get_parent().add_child.call_deferred(ricoball)
		get_parent().add_child.call_deferred(shotparticles)
		var x: float = mutation_part.snoutPositionX()
		var y: float = mutation_part.snoutPositionY()
		
		var snout_length = sqrt((x * x) + (y * y))
		
		if y < 0:
			theta = acos(x / snout_length)
		else:
			theta = 2 * PI -  acos(x / snout_length)
		
		ricoball.set_motion(x,y,theta,false)
		shotparticles.start_emit(x,y,theta)


func _on_auto_timer_timeout():
	var rico_ball = RICO_BALL.instantiate()
	get_parent().add_child.call_deferred(rico_ball)
	var x: float = mutation_part.snoutPositionX()
	var y: float = mutation_part.snoutPositionY()
	var snout_length = sqrt((x * x) + (y * y))
	if y < 0:
		theta = acos(x / snout_length)
	else:
		theta = 2 * PI -  acos(x / snout_length)
	rico_ball.set_motion(x,y,theta,true)
