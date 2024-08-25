extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const BOOGER_AREA = preload("res://scenes/boogers/booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var mutation_part = $"../Player/mutationPart"
@onready var auto_timer = $AutoTimer


var theta: float = 0.0

func _process(_delta):
	
	#if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		#shootBall()
	pass


func shootBall():
	var booger_area = BOOGER_AREA.instantiate()
	var shotparticles = SHOT_PARTICLES.instantiate()
	
	get_parent().add_child.call_deferred(booger_area)
	get_parent().add_child.call_deferred(shotparticles)
	var x: float = mutation_part.snoutPositionX()
	var y: float = mutation_part.snoutPositionY()
	
	var snout_length = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / snout_length)
	else:
		theta = 2 * PI -  acos(x / snout_length)
	
	booger_area.set_motion(x,y,theta,1)
	shotparticles.start_emit(x,y,theta)

func _on_auto_timer_timeout():
	shootBall()
	if Global.gameTimeScale > 0.1:
		auto_timer.start()
	else:
		auto_timer.stop()
