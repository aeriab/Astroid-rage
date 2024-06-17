extends Area2D
@onready var bass_boom = $BassBoom
@onready var rising_nebula = $RisingNebula

var x
var y
var theta
var speed = 500 * Global.bulletSpeed - 300

var _scale = Vector2(Global.bulletSize / 20.0 + 0.1 + (upgradeLevel / 3),Global.bulletSize / 20.0 + 0.1 + (upgradeLevel / 3))

var rot_motion: float = 1.0

var orig_speed: float = Global.bulletSpeed
var orig_rotate_speed: float

var mutationPart: int
var upgradeLevel: float = Global.barrelUpNumArray[mutationPart]

var firstTimeExploding: bool = true

var explosiveLifetime: float = 0.0

@onready var game_projectile = $GameProjectile
@onready var cpu_particles_2d_2 = $CPUParticles2D2
@onready var timer = $Timer

const DECAYING_GREEN_SPOT = preload("res://scenes/decaying_booger_area.tscn")

func areaName():
	return "Booger"

func _ready():
	rising_nebula.play(0.1)
	
	cpu_particles_2d_2.amount = int(Global.bulletSize * 4)
	cpu_particles_2d_2.speed_scale = Global.bulletSpeed * 0.03 + 0.1
	cpu_particles_2d_2.scale_amount_min = int(Global.damage * 6 + 10)
	cpu_particles_2d_2.scale_amount_max = int(Global.damage * 7 + 20)
	cpu_particles_2d_2.color = Color (1.0 - Global.damage / 20.0,1.0 - Global.damage / 20.0,1.0 + Global.damage / 20.0)
	
	orig_rotate_speed = randf_range(0.8,1.2)
	monitoring = true
	
	upgradeLevel = Global.barrelUpNumArray[mutationPart - 1]
	_scale = Vector2(Global.bulletSize / 20.0 + 0.1 + upgradeLevel / 10,Global.bulletSize / 20.0 + 0.1 + upgradeLevel / 10)
	set_scale(_scale)
	position.x = x
	position.y = y
	#if Global.barrelUpNumArray[mutationPart - 1] == 1:
		#game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile1.png")
	#elif Global.barrelUpNumArray[mutationPart - 1] == 2:
		#game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile2.png")
	#elif Global.barrelUpNumArray[mutationPart - 1] == 3:
		#game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile3.png")
	#elif Global.barrelUpNumArray[mutationPart - 1] == 4:
		#game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile4.png")
	#else:
		#game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile5.png")
	
	rotation = randf_range(0.0,6.3)
	scale.x = log(explosiveLifetime + 3) - 1
	scale.y = log(explosiveLifetime + 3) - 1

func setFreeLater():
	queue_free()

func set_motion(x1,y1,theta1,mutPart):
	x = x1
	y = y1
	theta = theta1
	rot_motion = Global.prior_dir
	mutationPart = mutPart

func _physics_process(delta):
	x += cos(theta) * speed * delta * Global.gameTimeScale
	y -= sin(theta) * speed * delta * Global.gameTimeScale
	
	explosiveLifetime += delta * Global.gameTimeScale
	material.set_shader_parameter("explosiveValue",explosiveLifetime / 5.0)
	
	scale.x = log(explosiveLifetime + 3) - 1
	scale.y = log(explosiveLifetime + 3) - 1
	
	position.x = x
	position.y = y
	
	rotate(delta * (orig_speed - 1) * rot_motion * 2 * orig_rotate_speed * Global.gameTimeScale)
	
	if Global.explodeBoogers && firstTimeExploding:
		var i: int = 0
		while i < int(explosiveLifetime * 20) + 2:
			var greenspot = DECAYING_GREEN_SPOT.instantiate()
			
			get_parent().add_child.call_deferred(greenspot)
			var x1: float = position.x
			var y1: float = position.y
			
			var snout_length = sqrt((x1 * x1) + (y1 * y1))
			
			if y1 < 0:
				theta = acos(x1 / snout_length) + randf_range(-PI,PI)
			else:
				theta = 2 * PI -  acos(x1 / snout_length)  + randf_range(-PI,PI)
			
			greenspot.set_motion(x1,y1,theta,1,1/explosiveLifetime)
			i += 1
		
		
		setFreeSequence()
		firstTimeExploding = false

@onready var collision_shape_2d = $CollisionShape2D

func setFreeSequence():
	bass_boom.volume_db = AudioPreload.effectsVolDB + (10 * log(explosiveLifetime / 5) + 5)
	bass_boom.pitch_scale = (1 / (explosiveLifetime + 1)) + 1.5
	bass_boom.play(0.1)
	rising_nebula.stop()
	firstTimeExploding = false
	cpu_particles_2d_2.emitting = true
	game_projectile.free()
	collision_shape_2d.free()
	timer.start()


func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()


func _on_timer_timeout():
	queue_free()
