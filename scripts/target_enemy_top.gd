extends Node2D

const DEFAULT_NOTIFICATION = preload("res://scenes/default_notification.tscn")

@onready var cpu_particles_2d = $CPUParticles2D

@onready var timer = $Timer

@onready var target_enemy = $targetEnemy
@onready var target_enemy_2 = $targetEnemy2
@onready var target_enemy_3 = $targetEnemy3

var shader_value = material.get_shader_parameter("value")
var shader_alpha = material.get_shader_parameter("alpha")
var damage_chunk = Global.damage * 0.05

var x = 5000
var y = 5000
var hypotenuse
var theta

const SPEED = 200
const FADE_SPEED = 0.5

var innerBoundX: float
var innerBoundY: float
var outerBoundX: float
var outerBoundY: float

var time_ellapsed = 0

var flipSprite: int = 1

var enemyIndex = 0

var xpAmount: float
var sizeOfEnemy: float

var speed: float

var difficulty: float = 1.0
@onready var splatcho_enemy = $SplatchoEnemy
var randEnSprite: int

func _ready():
	pass
	#cpu_particles_2d.scale_amount_min = 30.0 * sizeOfEnemy
	#cpu_particles_2d.scale_amount_max = 45.0 * sizeOfEnemy
	#cpu_particles_2d.amount = sizeOfEnemy * 3 + 10
	


func spawn(dif,spd):
	speed = spd
	innerBoundX = 2000 * speed
	innerBoundY = 2000 * speed
	outerBoundX = 3000 * speed
	outerBoundY = 3000 * speed
	
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

func _physics_process(delta):
	
	x -= cos(theta) * SPEED * speed * delta
	y -= -sin(theta) * SPEED * speed * delta
	
	scale.y = ((sin((time_ellapsed / sizeOfEnemy) * speed) * (sizeOfEnemy) * 0.2) + sizeOfEnemy) * flipSprite
	
	position = Vector2(x,y)
	time_ellapsed += delta * 5
	if shader_alpha != 1.0:
		shader_alpha += FADE_SPEED * delta
		shader_alpha = clamp(shader_alpha,0.0,1.0)
		material.set_shader_parameter("alpha_value",shader_alpha)

var tsize: float = 100.0
var points: float = 0.0
var fadeSpeed: float = 0.001
var tcolor: Color = Color.WHITE

func addDamage():
	Global.decreaseEnemyNum()
	Global.addXP(xpAmount)
	var pointsNotif = DEFAULT_NOTIFICATION.instantiate()
	pointsNotif.position = Vector2 (x,y)
	pointsNotif.establishText(str(points) + " POINTS",tsize,tcolor,fadeSpeed,0.0)
	get_parent().add_child.call_deferred(pointsNotif)
	setFreeSequence()

func setFreeSequence():
	cpu_particles_2d.emitting = true
	splatcho_enemy.queue_free()
	target_enemy.queue_free()
	target_enemy_2.queue_free()
	target_enemy_3.queue_free()
	timer.start()

func _on_timer_timeout():
	queue_free()


func _on_target_enemy_area_entered(area):
	tcolor = Color.WHITE
	fadeSpeed = 0.2
	tsize = 1.0
	points = 20
	
	if area.is_in_group("BoogerArea"):
		Global.consecBulls = 0
		Global.points += 20
		cpu_particles_2d.speed_scale = 1.0
		cpu_particles_2d.scale_amount_min = 0.02
		cpu_particles_2d.scale_amount_max = 0.04
		cpu_particles_2d.amount = 5.0
		cpu_particles_2d.texture = preload("res://assets/Square Particle.png")
		area.setFreeSequence()
		addDamage()
	 
	if area.is_in_group("Player"):
		Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
		Global.enemyNum -= 1
		setFreeSequence()

func _on_target_enemy_2_area_entered(area):
	tcolor = Color.WHITE
	fadeSpeed = 0.15
	tsize = 1.5
	points = 40
	
	if area.is_in_group("BoogerArea"):
		Global.consecBulls = 0
		Global.points += 40
		cpu_particles_2d.speed_scale = 1.5
		cpu_particles_2d.scale_amount_min = 0.03
		cpu_particles_2d.scale_amount_max = 0.06
		cpu_particles_2d.amount = 15.0
		cpu_particles_2d.texture = preload("res://assets/Square Particle.png")
		area.setFreeSequence()
		addDamage()
	 
	if area.is_in_group("Player"):
		Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
		Global.enemyNum -= 1
		setFreeSequence()


func _on_target_enemy_3_area_entered(area):
	tcolor = Color.WHITE
	fadeSpeed = 0.1
	tsize = 2.5
	
	if area.is_in_group("BoogerArea"):
		Global.consecBulls += 1
		points = 100 * Global.consecBulls
		Global.points += 100 * Global.consecBulls
		
		if Global.consecBulls >= 2:
			var bonusNotif = DEFAULT_NOTIFICATION.instantiate()
			bonusNotif.position = Vector2 (x + 900,y - 600)
			bonusNotif.establishText("x" + str(Global.consecBulls) + "  BULL'S EYE!",tsize/5 + (tsize / 10) * Global.consecBulls,tcolor,fadeSpeed,20)
			get_parent().add_child.call_deferred(bonusNotif)
		
		cpu_particles_2d.speed_scale = 2.0
		cpu_particles_2d.scale_amount_min = 0.5
		cpu_particles_2d.scale_amount_max = 0.8
		cpu_particles_2d.amount = int(10.0 + log(Global.consecBulls) * 10.0)
		cpu_particles_2d.texture = preload("res://assets/Star Particle (1).png")
		
		area.setFreeSequence()
		addDamage()
	 
	if area.is_in_group("Player"):
		Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
		Global.enemyNum -= 1
		setFreeSequence()



