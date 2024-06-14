extends Node

const GREEN_SPOT = preload("res://scenes/booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

@onready var mutation_part = $"../Player/mutationPart"


var theta: float = 0.0

#func shoot():
	#var greenspot = GREEN_SPOT.instantiate()
	#var shotparticles = SHOT_PARTICLES.instantiate()
	#
	#get_parent().add_child.call_deferred(greenspot)
	#get_parent().add_child.call_deferred(shotparticles)
	#var x: float = mutation_part.snoutPositionX()
	#var y: float = mutation_part.snoutPositionY()
	##x = snout_position.global_position.x
	##y = snout_position.global_position.y
	#
	#var snout_length = sqrt((x * x) + (y * y))
	#
	#if y < 0:
		#theta = acos(x / snout_length)
	#else:
		#theta = 2 * PI -  acos(x / snout_length)
	#
	#greenspot.set_motion(x,y,theta)
	#shotparticles.start_emit(x,y,theta)
	##greenspot.position = Vector2(x,y)
	##greenspot.linear_velocity = Vector2(cos(theta) * SPEED,-sin(theta) * SPEED)
#
#func shoot2():
	#var greenspot = GREEN_SPOT.instantiate()
	#var shotparticles = SHOT_PARTICLES.instantiate()
	#
	#get_parent().add_child.call_deferred(greenspot)
	#get_parent().add_child.call_deferred(shotparticles)
	#var x: float = mutation_part_2.snoutPositionX()
	#var y: float = mutation_part_2.snoutPositionY()
	##x = snout_position.global_position.x
	##y = snout_position.global_position.y
	#
	#var snout_length = sqrt((x * x) + (y * y))
	#
	#if y < 0:
		#theta = acos(x / snout_length)
	#else:
		#theta = 2 * PI -  acos(x / snout_length)
	#
	#greenspot.set_motion(x,y,theta)
	#shotparticles.start_emit(x,y,theta)
	##greenspot.position = Vector2(x,y)
	##greenspot.linear_velocity = Vector2(cos(theta) * SPEED,-sin(theta) * SPEED)

func _process(_delta):
	if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		var greenspot = GREEN_SPOT.instantiate()
		var shotparticles = SHOT_PARTICLES.instantiate()
		
		get_parent().add_child.call_deferred(greenspot)
		get_parent().add_child.call_deferred(shotparticles)
		var x: float = mutation_part.snoutPositionX()
		var y: float = mutation_part.snoutPositionY()
		
		var snout_length = sqrt((x * x) + (y * y))
		
		if y < 0:
			theta = acos(x / snout_length)
		else:
			theta = 2 * PI -  acos(x / snout_length)
		
		greenspot.set_motion(x,y,theta,1)
		shotparticles.start_emit(x,y,theta)
