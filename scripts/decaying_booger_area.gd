extends Area2D

var x
var y
var theta
var SPEED = 500 * Global.bulletSpeed - 300

var _scale = Vector2(Global.bulletSize / 20.0 + 0.1 + (upgradeLevel / 3),Global.bulletSize / 20.0 + 0.1 + (upgradeLevel / 3))

var rot_motion: float = 1.0

var orig_speed: float = Global.bulletSpeed
var orig_rotate_speed: float

var mutationPart: int
var upgradeLevel: float = Global.barrelUpNumArray[mutationPart]

@onready var game_projectile = $GameProjectile

func areaName():
	return "Booger"

func _ready():
	
	orig_rotate_speed = randf_range(0.8,1.2)
	monitoring = true
	
	upgradeLevel = Global.barrelUpNumArray[mutationPart - 1]
	_scale = Vector2(Global.bulletSize / 20.0 + 0.1 + upgradeLevel / 10,Global.bulletSize / 20.0 + 0.1 + upgradeLevel / 10)
	set_scale(_scale)
	position.x = x
	position.y = y
	if Global.barrelUpNumArray[mutationPart - 1] == 1:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile1.png")
	elif Global.barrelUpNumArray[mutationPart - 1] == 2:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile2.png")
	elif Global.barrelUpNumArray[mutationPart - 1] == 3:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile3.png")
	elif Global.barrelUpNumArray[mutationPart - 1] == 4:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile4.png")
	else:
		game_projectile.texture = preload("res://assets/damageProjectiles/DamGameProjectile5.png")
	
	rotation = randf_range(0.0,6.3)

func setFreeLater():
	queue_free()

var scaleDown: float = 0.0

func set_motion(x1,y1,theta1,mutPart,sDown):
	x = x1
	y = y1
	theta = theta1
	rot_motion = Global.prior_dir
	mutationPart = mutPart
	scaleDown = sDown

func _physics_process(delta):
	x += cos(theta) * SPEED * delta * Global.gameTimeScale
	y -= sin(theta) * SPEED * delta * Global.gameTimeScale
	
	position.x = x
	position.y = y
	
	rotate(delta * (orig_speed - 1) * rot_motion * 2 * orig_rotate_speed * Global.gameTimeScale)
	
	if scale.x - delta * Global.gameTimeScale < 0.05:
		queue_free()
	else:
		scale.x -= delta * Global.gameTimeScale * 0.1 * scaleDown
		scale.y -= delta * Global.gameTimeScale * 0.1 * scaleDown

@onready var collision_shape_2d = $CollisionShape2D

func setFreeSequence():
	queue_free()

func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()
