extends Node2D
@onready var cpu_particles_2d = $SnoutPosition/CPUParticles2D
@onready var snout_position = $SnoutPosition


func noseScale():
	pass

func scaleNose(_num):
	pass

func scaleEyelid(_num):
	pass

func scalePupil(_num):
	pass

func snoutPositionX():
	return snout_position.global_position.x

func snoutPositionY():
	return snout_position.global_position.y



func setFire(val):
	if val > 0:
		cpu_particles_2d.color = Color8(100 + val*20,100 - val*20,100 - val*20,255)
		
		cpu_particles_2d.emitting = true
	else:
		cpu_particles_2d.emitting = false
	
