extends Area2D

var x
var y
var theta
var SPEED = 500 * Global.bulletSpeed - 300

var _scale = Vector2(Global.bulletSize / 20.0 + 0.1 + upgradeLevel / 10,Global.bulletSize / 20.0 + 0.1 + upgradeLevel / 10)
var rot_motion: float = 1.0

var orig_speed: float = Global.bulletSpeed
var orig_rotate_speed: float

var mutationPart: int
var upgradeLevel: float = Global.barrelUpNumArray[mutationPart]

@onready var game_projectile = $GameProjectile
@onready var cpu_particles_2d_2 = $CPUParticles2D2
@onready var timer = $Timer

var thrustBooger: bool = true

var softShot: bool = false

func areaName():
	return "Booger"

func _ready():
	if thrustBooger:
		game_projectile.texture = preload("res://assets/thrustSpray (4).png")
	
	cpu_particles_2d_2.amount = int(Global.bulletSize * 4)
	cpu_particles_2d_2.speed_scale = Global.bulletSpeed * 0.03 + 0.1
	cpu_particles_2d_2.scale_amount_min = int(Global.damage * 6 + 10)
	cpu_particles_2d_2.scale_amount_max = int(Global.damage * 7 + 20)
	cpu_particles_2d_2.color = Color (1.0 - Global.damage / 20.0,1.0 - Global.damage / 20.0,1.0 + Global.damage / 20.0)
	
	orig_rotate_speed = randf_range(0.8,1.2)
	monitoring = true
	
	upgradeLevel = Global.barrelUpNumArray[mutationPart - 1]
	set_scale(_scale * 0.0)
	global_position.x = x
	global_position.y = y
	rotation = randf_range(0.0,6.3)

func setFreeLater():
	queue_free()

func set_motion(x1,y1,theta1,mutPart):
	x = x1
	y = y1
	theta = theta1
	rot_motion = Global.prior_dir
	mutationPart = mutPart

func mod_scale(scale_num):
	set_scale(scale_num)
	_scale = scale_num

var scale_prog: float = 0.0

func _physics_process(delta):
	
	if scale_prog < 0.8:
		scale_prog += Global.gameTimeScale * delta * 35
		set_scale(_scale * scale_prog)
	else:
		set_scale(_scale * 0.8)
	
	x += cos(theta) * SPEED * delta * Global.gameTimeScale
	y -= sin(theta) * SPEED * delta * Global.gameTimeScale
	
	global_position.x = x
	global_position.y = y
	
	rotate(delta * (orig_speed - 1) * rot_motion * 10 * orig_rotate_speed * Global.gameTimeScale)

@onready var collision_shape_2d = $CollisionShape2D

func setFreeSequence():
	cpu_particles_2d_2.emitting = true
	game_projectile.free()
	collision_shape_2d.free()
	timer.start()


func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()


func _on_timer_timeout():
	queue_free()
