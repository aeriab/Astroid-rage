extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const BOOGER_AREA = preload("res://scenes/boogers/booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var mutation_part = $"../Player/mutationPart"

@onready var mutation_part_2 = $"../Player/mutationPart2"
@onready var mutation_part_3_1_ = $"../Player/mutationPart3(1)"
@onready var mutation_part_3_2_ = $"../Player/mutationPart3(2)"
@onready var mutation_part_4_1_ = $"../Player/mutationPart4(1)"
@onready var mutation_part_4_2_ = $"../Player/mutationPart4(2)"
@onready var mutation_part_5_1_ = $"../Player/mutationPart5(1)"
@onready var mutation_part_5_2_ = $"../Player/mutationPart5(2)"
@onready var mutation_part_5_3_ = $"../Player/mutationPart5(3)"
@onready var mutation_part_5_4_ = $"../Player/mutationPart5(4)"
@onready var mutation_part_6_1_ = $"../Player/mutationPart6(1)"
@onready var mutation_part_6_5_ = $"../Player/mutationPart6(5)"

@onready var auto_timer = $AutoTimer

var theta: float = 0.0
var firstResume: bool = true

func _ready():
	if Global.num_base_stars1 >= 1:
		auto_timer.start()
		auto_timer.wait_time = (6.0 / (float(Global.num_base_stars1) + 2.0)) / Global.gameTimeScale

func _process(_delta):
	auto_timer.wait_time = (6.0 / (float(Global.num_base_stars1) + 2.0)) / Global.gameTimeScale
	if Global.gameTimeScale < 0.1:
		auto_timer.stop()
		firstResume = true
	elif Global.num_base_stars1 >= 1 && firstResume:
		auto_timer.start()
		firstResume = false
	
	if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		shootBall(mutation_part)
		if Global.num_base_stars2 == 1:
			shootBallSoft(mutation_part_2)
		elif Global.num_base_stars2 == 2:
			shootBallSoft(mutation_part_3_1_)
			shootBallSoft(mutation_part_3_2_)
		elif Global.num_base_stars2 == 3:
			shootBallSoft(mutation_part_4_1_)
			shootBallSoft(mutation_part_4_2_)
			shootBallSoft(mutation_part_2)
		elif Global.num_base_stars2 == 4:
			shootBallSoft(mutation_part_5_1_)
			shootBallSoft(mutation_part_5_2_)
			shootBallSoft(mutation_part_5_3_)
			shootBallSoft(mutation_part_5_4_)
		elif Global.num_base_stars2 == 5:
			shootBallSoft(mutation_part_2)
			shootBallSoft(mutation_part_3_1_)
			shootBallSoft(mutation_part_3_2_)
			shootBallSoft(mutation_part_6_1_)
			shootBallSoft(mutation_part_6_5_)


func shootBallSoft(mpart):
	var booger_area = BOOGER_AREA.instantiate()
	get_parent().add_child.call_deferred(booger_area)
	var x: float = mpart.snoutPositionX()
	var y: float = mpart.snoutPositionY()
	var snout_length = sqrt((x * x) + (y * y))
	if y < 0:
		theta = acos(x / snout_length)
	else:
		theta = 2 * PI -  acos(x / snout_length)
	booger_area.set_motion(x,y,theta,true)


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
	
	booger_area.set_motion(x,y,theta,false)
	shotparticles.start_emit(x,y,theta)

func _on_auto_timer_timeout():
	shootBallSoft(mutation_part)
	if Global.num_base_stars2 == 1:
		shootBallSoft(mutation_part_2)
	elif Global.num_base_stars2 == 2:
		shootBallSoft(mutation_part_3_1_)
		shootBallSoft(mutation_part_3_2_)
	elif Global.num_base_stars2 == 3:
		shootBallSoft(mutation_part_4_1_)
		shootBallSoft(mutation_part_4_2_)
		shootBallSoft(mutation_part_2)
	elif Global.num_base_stars2 == 4:
		shootBallSoft(mutation_part_5_1_)
		shootBallSoft(mutation_part_5_2_)
		shootBallSoft(mutation_part_5_3_)
		shootBallSoft(mutation_part_5_4_)
	elif Global.num_base_stars2 == 5:
		shootBallSoft(mutation_part_2)
		shootBallSoft(mutation_part_3_1_)
		shootBallSoft(mutation_part_3_2_)
		shootBallSoft(mutation_part_6_1_)
		shootBallSoft(mutation_part_6_5_)


