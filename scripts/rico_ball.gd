extends Area2D

var x
var y
var theta
var SPEED = 500 * Global.bulletSpeed - 300

var rot_motion: float = 1.0

var orig_speed: float = Global.bulletSpeed
var orig_rotate_speed: float

var mutationPart: int
var upgradeLevel: float = Global.barrelUpNumArray[mutationPart]

@onready var game_projectile = $GameProjectile
@onready var cpu_particles_2d_2 = $CPUParticles2D2
@onready var timer = $Timer

var canBounce: bool = true

func areaName():
	return "Booger"

func _ready():
	cpu_particles_2d_2.amount = int(Global.bulletSize * 4)
	cpu_particles_2d_2.speed_scale = Global.bulletSpeed * 0.03 + 0.1
	cpu_particles_2d_2.scale_amount_min = int(Global.damage * 6 + 10)
	cpu_particles_2d_2.scale_amount_max = int(Global.damage * 7 + 20)
	cpu_particles_2d_2.color = Color (1.0 - Global.damage / 20.0,1.0 - Global.damage / 20.0,1.0 + Global.damage / 20.0)
	
	orig_rotate_speed = randf_range(0.8,1.2)
	monitoring = true
	
	upgradeLevel = Global.barrelUpNumArray[mutationPart - 1]
	
	position.x = x
	position.y = y
	
	rotation = randf_range(0.0,6.3)

func setFreeLater():
	queue_free()

func set_motion(x1,y1,theta1,mutPart):
	x = x1
	y = y1
	theta = theta1
	rot_motion = Global.prior_dir
	mutationPart = mutPart

func _physics_process(delta):
	
	x += cos(theta) * SPEED * delta * Global.gameTimeScale
	y -= sin(theta) * SPEED * delta * Global.gameTimeScale
	
	position.x = x
	position.y = y
	
	rotate(delta * (orig_speed - 1) * rot_motion * 2 * orig_rotate_speed * Global.gameTimeScale)

@onready var collision_shape_2d = $CollisionShape2D
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")
const RICO_BALL = preload("res://scenes/boogers/rico_ball.tscn")

func setFreeSequence():
	if canBounce:
		canBounce = false
		cpu_particles_2d_2.emitting = true
		timer.start()
		
		theta = theta - randf_range(2 * PI/3,4 * PI/3)


func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()


func _on_timer_timeout():
	canBounce = true
