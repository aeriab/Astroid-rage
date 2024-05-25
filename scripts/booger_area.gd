extends Area2D

var x
var y
var theta
var SPEED = 500 * Global.bulletSpeed - 300

var _scale = Vector2(Global.bulletSize / 8.0,Global.bulletSize / 8.0)

var rot_motion: float = 1.0

var orig_speed: float = Global.bulletSpeed
@onready var game_projectile = $GameProjectile

var randImageNum: int

func _ready():
	monitoring = true
	set_scale(_scale)
	position.x = x
	position.y = y
	randImageNum = randi_range(0,4)
	if randImageNum == 0:
		game_projectile.texture = preload("res://assets/damage1Projectiles/Dam1GameProjectile.png")
	elif randImageNum == 1:
		game_projectile.texture = preload("res://assets/damage1Projectiles/Dam1GameProjectile (1).png")
	elif randImageNum == 2:
		game_projectile.texture = preload("res://assets/damage1Projectiles/Dam1GameProjectile (2).png")
	elif randImageNum == 3:
		game_projectile.texture = preload("res://assets/damage1Projectiles/Dam1GameProjectile (3).png")
	else:
		game_projectile.texture = preload("res://assets/damage1Projectiles/Dam1GameProjectile (4).png")
	
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
	
	rotate(delta * (orig_speed - 1) * rot_motion * 2 * randf_range(0.8,1.2))

func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()
