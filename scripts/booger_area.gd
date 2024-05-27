extends Area2D

var x
var y
var theta
var SPEED = 500 * Global.bulletSpeed - 300

var _scale = Vector2(Global.bulletSize / 15.0 + 0.1,Global.bulletSize / 15.0 + 0.1)

var rot_motion: float = 1.0

var orig_speed: float = Global.bulletSpeed
var orig_rotate_speed: float
@onready var game_projectile = $GameProjectile

func areaName():
	return "Booger"

func _ready():
	orig_rotate_speed = randf_range(0.8,1.2)
	monitoring = true
	set_scale(_scale)
	position.x = x
	position.y = y
	if Global.damage == 4:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile1.png")
	elif Global.damage <= 8:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile2.png")
	elif Global.damage <= 13:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile3.png")
	elif Global.damage <= 17:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile4.png")
	else:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile5.png")
	
	rotation = randf_range(0.0,6.3)

func setFreeLater():
	queue_free()

func set_motion(x1,y1,theta1):
	x = x1
	y = y1
	theta = theta1
	rot_motion = Global.prior_dir

func _physics_process(delta):
	
	x += cos(theta) * SPEED * delta
	y -= sin(theta) * SPEED * delta
	
	position.x = x
	position.y = y
	
	rotate(delta * (orig_speed - 1) * rot_motion * 2 * orig_rotate_speed)

func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()
