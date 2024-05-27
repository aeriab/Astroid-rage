extends Node2D

@onready var cpu_particles_2d = $CPUParticles2D

var x_dir: float = 0.0
var y_dir: float = 0.0

func _ready():
	cpu_particles_2d.restart()
	cpu_particles_2d.direction.x = x_dir
	cpu_particles_2d.direction.y = y_dir
	cpu_particles_2d.color = Color (1.0 - Global.damage / 20.0,1.0 - Global.damage / 20.0,1.0 + Global.damage / 20.0)
	cpu_particles_2d.scale_amount_min = 10 * Global.bulletSize
	cpu_particles_2d.scale_amount_max = 15 * Global.bulletSize
	cpu_particles_2d.speed_scale = 0.05 * Global.bulletSpeed + 0.3
	cpu_particles_2d.lifetime = 0.01 * Global.bulletSpeed + 0.1

func start_emit(x,y,theta):
	position.x = x
	position.y = y
	
	x_dir = cos(theta)
	y_dir = -sin(theta)


func _on_cpu_particles_2d_finished():
	queue_free()
