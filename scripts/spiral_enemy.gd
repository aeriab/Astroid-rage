extends Area2D

const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")

@onready var cpu_particles_2d = $CPUParticles2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var timer = $Timer

var shader_value = material.get_shader_parameter("value")
var shader_alpha = material.get_shader_parameter("alpha")
var damage_chunk = Global.damage * 0.05

var x = 5000
var y = 5000
var hypotenuse
var theta

const SPEED = 200
const FADE_SPEED = 0.5

var innerBoundX = 5000
var innerBoundY = 5000
var outerBoundX = 6000
var outerBoundY = 6000

var time_ellapsed = 0

var flipSprite: int = 1

var enemyIndex = 0

var xpAmount: float
var sizeOfEnemy: float

var difficulty: float = 1.0
@onready var spiral_enemy = $SpiralEnemy

var randEnSprite: int

func _ready():
	randEnSprite = randi_range(0,100)
	if randEnSprite <= 35:
		spiral_enemy.texture = preload("res://assets/spiralEnemySprites/SpiralEnemy.png")
	elif randEnSprite <= 65:
		spiral_enemy.texture = preload("res://assets/spiralEnemySprites/SpiralEnemyStar.png")
	else:
		spiral_enemy.texture = preload("res://assets/spiralEnemySprites/SpiralEnemyBrow.png")
	
	cpu_particles_2d.scale_amount_min = 30.0 * sizeOfEnemy
	cpu_particles_2d.scale_amount_max = 45.0 * sizeOfEnemy
	cpu_particles_2d.amount = sizeOfEnemy * 3 + 10

func spawn(dif):
	difficulty = dif
	Global.enemyNum += 1
	enemyIndex = Global.enemyNum
	
	sizeOfEnemy = randf_range(0.5 * difficulty,1.5 * difficulty)
	xpAmount = sizeOfEnemy + pow(sizeOfEnemy,2.0)
	if sizeOfEnemy >= 1.48 * difficulty:
		sizeOfEnemy = 3.0 * difficulty
	
	
	damage_chunk = Global.damage / (pow(sizeOfEnemy,2) * 10) 
	
	shader_alpha = 0.0
	
	material.set_shader_parameter("alpha_value",shader_alpha)
	
	randomize()
	shader_value = 0.0
	
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)
	
	rotation = -theta + PI
	scale.x = sizeOfEnemy
	scale.y = sizeOfEnemy * flipSprite

func _physics_process(delta):
	
	x -= cos(theta) * SPEED * delta
	y -= -sin(theta) * SPEED * delta
	
	scale.x = ((sin(time_ellapsed / sizeOfEnemy) * (sizeOfEnemy) * 0.2) + sizeOfEnemy)
	
	position = Vector2(x,y)
	time_ellapsed += delta * 5
	if shader_alpha != 1.0:
		shader_alpha += FADE_SPEED * delta
		shader_alpha = clamp(shader_alpha,0.0,1.0)
		material.set_shader_parameter("alpha_value",shader_alpha)
	

func addDamage():
	shader_value = shader_value + damage_chunk
	
	shader_value = clamp(shader_value,0.0,1.0)
	
	material.set_shader_parameter("damage_value",shader_value)
	
	if shader_value >= 0.9:
		Global.decreaseEnemyNum()
		Global.addXP(xpAmount)
		var xpNotif = XP_NOTIFICATION.instantiate()
		xpNotif.position = Vector2 (x,y)
		xpNotif.getXPSize(xpAmount)
		get_parent().add_child.call_deferred(xpNotif)
		setFreeSequence()

func _on_area_entered(area):
	if area.is_in_group("BoogerArea"):
		area.setFreeSequence()
		addDamage()
	 
	if area.is_in_group("Player"):
		Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
		Global.enemyNum -= 1
		call_deferred("queue_free")

func setFreeSequence():
	cpu_particles_2d.emitting = true
	spiral_enemy.free()
	collision_shape_2d.free()
	collision_polygon_2d.free()
	timer.start()

func _on_timer_timeout():
	queue_free()
