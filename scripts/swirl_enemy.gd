extends Area2D

const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")
const DEFAULT_NOTIFICATION = preload("res://scenes/default_notification.tscn")
var points: float = 0.0

@onready var cpu_particles_2d = $CPUParticles2D
@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var timer = $Timer

var shader_value = material.get_shader_parameter("value")
var shader_alpha = material.get_shader_parameter("alpha")
var damage_chunk = Global.damage * 0.05

var x = 5000
var y = 5000
var hypotenuse
var theta

const SPEED = 1000
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
@onready var swirl_enemy = $SwirlEnemy

var randEnSprite: int
var direction: int = 1

func _ready():
	randEnSprite = randi_range(0,100)
	if randEnSprite <= 25:
		swirl_enemy.texture = preload("res://assets/swirlEnemySprites/SwirlEnemyBoth.png")
	elif randEnSprite <= 50:
		swirl_enemy.texture = preload("res://assets/swirlEnemySprites/SwirlEnemySquare.png")
	elif randEnSprite <= 75:
		swirl_enemy.texture = preload("res://assets/swirlEnemySprites/SwirlEnemyTriangle.png")
	else:
		swirl_enemy.texture = preload("res://assets/swirlEnemySprites/SwirlEnemyTrifront.png")
	
	cpu_particles_2d.scale_amount_min = 30.0 * sizeOfEnemy
	cpu_particles_2d.scale_amount_max = 45.0 * sizeOfEnemy
	cpu_particles_2d.amount = sizeOfEnemy * 3 + 10

func spawn(dif,xgiven,ygiven,flipgiven):
	direction = randi_range(0,1)
	difficulty = dif
	Global.enemyNum += 1
	enemyIndex = Global.enemyNum
	
	sizeOfEnemy = randf_range(0.5 * difficulty,1.5 * difficulty)
	
	xpAmount = sizeOfEnemy + pow(sizeOfEnemy,2.0)
	if sizeOfEnemy >= 1.48 * difficulty:
		sizeOfEnemy = 3.0 * difficulty
	scale.x = sizeOfEnemy
	scale.y = sizeOfEnemy
	damage_chunk = Global.damage / (pow(sizeOfEnemy,2) * 10) 
	
	shader_alpha = 0.0
	
	material.set_shader_parameter("alpha_value",shader_alpha)
	
	randomize()
	shader_value = 0.0
	
	x = xgiven
	y = ygiven
	flipSprite = flipgiven
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)
	
	scale.x = sizeOfEnemy * 0.6
	scale.y = sizeOfEnemy * flipSprite * 0.6

func _physics_process(delta):

	if direction == 1:
		x -= sin(theta) * SPEED * delta * Global.gameTimeScale
		y -= cos(theta) * SPEED * delta * Global.gameTimeScale
	else:
		x += sin(theta) * SPEED * delta * Global.gameTimeScale
		y += cos(theta) * SPEED * delta * Global.gameTimeScale
	
	hypotenuse = sqrt((x * x) + (y * y))
	if direction == 1:
		if y < 0:
			theta = acos(x / hypotenuse) + 0.3
		else:
			theta = 2 * PI -  acos(x / hypotenuse) + 0.3
	else:
		if y < 0:
			theta = acos(x / hypotenuse) - 0.3
		else:
			theta = 2 * PI -  acos(x / hypotenuse) - 0.3
	
	if direction == 1:
		rotation = -theta - PI / 2
	else:
		rotation = -theta + PI / 2
	#scale.x = ((sin(time_ellapsed / sizeOfEnemy) * (sizeOfEnemy) * 0.2) + sizeOfEnemy)
	
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
		var pointsNotif = DEFAULT_NOTIFICATION.instantiate()
		pointsNotif.position = Vector2 (x,y)
		points = sizeOfEnemy * 100
		Global.points += int(points)
		pointsNotif.establishText(str(int(points)) + " POINTS",sizeOfEnemy,Color.WHITE,0.1,0.0)
		get_parent().add_child.call_deferred(pointsNotif)
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
	swirl_enemy.free()
	collision_polygon_2d.free()
	timer.start()

func _on_timer_timeout():
	queue_free()
