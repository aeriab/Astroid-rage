extends Node

const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var mutation_part = $"../Player/mutationPart"


var theta: float = 0.0

func _process(_delta):
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
		
		ricoball.set_motion(x,y,theta,1)
		shotparticles.start_emit(x,y,theta)
