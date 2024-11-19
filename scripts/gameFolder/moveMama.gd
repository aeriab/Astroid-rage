extends Area2D

var SPEED = 100.0
var ROT_SPEED = 1.0

var direction = 1
var theta: float = PI/2
var x: float = -2500.0
var y: float = 0.0
var hypotenuse: float = 2500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = 1
	difficulty = 1
	Global.enemyNum += 1
	enemyIndex = Global.enemyNum
	
	sizeOfEnemy = 1
	
	xpAmount = 1
	damage_chunk = Global.damage / (pow(10,2) * 10) 
	
	shader_alpha = 0.0
	
	material.set_shader_parameter("alpha_value",shader_alpha)
	
	randomize()
	shader_value = 0.0
	
	x = -2500
	y = 0
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == 1:
		x -= sin(theta - PI/2) * SPEED * delta * Global.gameTimeScale
		y -= cos(theta - PI/2) * SPEED * delta * Global.gameTimeScale
	
	hypotenuse = sqrt((x * x) + (y * y))
	if direction == 1:
		if y < 0:
			theta = PI/2 + acos(x / hypotenuse) + 0.1
		else:
			theta = PI/2 + (2 * PI -  acos(x / hypotenuse) + 0.1)
	
	if direction == 1:
		rotation = -theta - PI / 2
	
	position = Vector2(x,y)






const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")
const DEFAULT_NOTIFICATION = preload("res://scenes/default_notification.tscn")
var points: float = 0.0

@onready var cpu_particles_2d = $CPUParticles2D
@onready var collision_polygon_2d = $CollisionShape2D
@onready var timer = $Timer

var shader_value = material.get_shader_parameter("value")
var shader_alpha = material.get_shader_parameter("alpha")
var damage_chunk = Global.damage * 0.05

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
@onready var swirl_enemy = $PolygonContainer

var randEnSprite: int

var stopMoving: bool = false
var alreadyFree: bool = false

func _physics_process(delta):
	if direction == 1:
		x -= sin(theta - PI/2) * SPEED * delta * Global.gameTimeScale
		y -= cos(theta - PI/2) * SPEED * delta * Global.gameTimeScale
	
	hypotenuse = sqrt((x * x) + (y * y))
	if direction == 1:
		if y < 0:
			theta = PI/2 + acos(x / hypotenuse) + 0.1
		else:
			theta = PI/2 + (2 * PI -  acos(x / hypotenuse) + 0.1)
	
	if direction == 1:
		rotation = -theta - PI / 2
	
	position = Vector2(x,y)
	
	if !Global.crashStarted && stopMoving && !alreadyFree:
		Global.decreaseEnemyNum()
		Global.addXP(xpAmount)
		var pointsNotif = DEFAULT_NOTIFICATION.instantiate()
		pointsNotif.position = Vector2 (x,y)
		points = sizeOfEnemy * 100
		Global.points += int(points)
		pointsNotif.establishText(str(int(points)) + " POINTS",sizeOfEnemy,Color.WHITE,0.1,0.0,Global.inPracticeMode)
		get_parent().add_child.call_deferred(pointsNotif)
		setFreeSequence()
		alreadyFree = true
	
	time_ellapsed += delta * 5
	if shader_alpha != 1.0:
		shader_alpha += FADE_SPEED * delta
		shader_alpha = clamp(shader_alpha,0.0,1.0)
		material.set_shader_parameter("alpha_value",shader_alpha)
	
	for area in get_overlapping_areas():
		if area.is_in_group("Lazer"):
			if Global.player_health < 100.0:
				Global.player_health += ((Global.gameTimeScale * delta * 2.0) * ((Global.num_base_stars1 * 0.3) + 1.0)) * Global.lazerDamage
			shader_value = shader_value + (damage_chunk * delta * Global.gameTimeScale * Global.lazerDamage)
			shader_value = clamp(shader_value,0.0,1.0)
			material.set_shader_parameter("damage_value",shader_value)
			if shader_value >= 0.9:
				if !alreadyFree:
					Global.decreaseEnemyNum()
					Global.addXP(xpAmount)
					var pointsNotif = DEFAULT_NOTIFICATION.instantiate()
					pointsNotif.position = Vector2 (x,y)
					points = sizeOfEnemy * 100
					Global.points += int(points)
					pointsNotif.establishText(str(int(points)) + " POINTS",sizeOfEnemy,Color.WHITE,0.1,0.0,Global.inPracticeMode)
					get_parent().add_child.call_deferred(pointsNotif)
					setFreeSequence()
					alreadyFree = true


func tickleDamage():
	shader_value = shader_value + (damage_chunk * Global.TICKLE_MULT)
	shader_value = clamp(shader_value,0.0,1.0)
	material.set_shader_parameter("damage_value",shader_value)
	if shader_value >= 0.9:
		if !alreadyFree:
			Global.decreaseEnemyNum()
			Global.addXP(xpAmount)
			var pointsNotif = DEFAULT_NOTIFICATION.instantiate()
			pointsNotif.position = Vector2 (x,y)
			points = sizeOfEnemy * 100
			Global.points += int(points)
			pointsNotif.establishText(str(int(points)) + " POINTS",sizeOfEnemy,Color.WHITE,0.1,0.0,Global.inPracticeMode)
			get_parent().add_child.call_deferred(pointsNotif)
			setFreeSequence()
			alreadyFree = true


func addDamage():
	shader_value = shader_value + damage_chunk
	
	shader_value = clamp(shader_value,0.0,1.0)
	
	material.set_shader_parameter("damage_value",shader_value)
	
	if shader_value >= 0.9:
		if !alreadyFree:
			Global.decreaseEnemyNum()
			Global.addXP(xpAmount)
			var pointsNotif = DEFAULT_NOTIFICATION.instantiate()
			pointsNotif.position = Vector2 (x,y)
			points = sizeOfEnemy * 100
			Global.points += int(points)
			pointsNotif.establishText(str(int(points)) + " POINTS",sizeOfEnemy,Color.WHITE,0.1,0.0,Global.inPracticeMode)
			get_parent().add_child.call_deferred(pointsNotif)
			setFreeSequence()
			alreadyFree = true

func moveWithGob():
	x += Global.gobXMovement
	y += Global.gobYMovement
	position = Vector2(x,y)
	
	if !alreadyFree:
		collision_polygon_2d.disabled = true


func _on_area_entered(area):
	if area.is_in_group("BoogerArea"):
		if area.softShot:
			tickleDamage()
		else:
			addDamage()
		area.setFreeSequence()
	
	if area.is_in_group("Crasher") || area.is_in_group("Gob"):
		area.bounceBack(position.x,position.y)
	
	if area.is_in_group("Player"):
		if !alreadyFree:
			Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
			Global.enemyNum -= 1
			setFreeSequence()
			alreadyFree = true

@onready var tl_target = $"../IKTargets/TLTarget"
@onready var bl_target = $"../IKTargets/BLTarget"
@onready var tr_target = $"../IKTargets/TRTarget"
@onready var br_target = $"../IKTargets/BRTarget"

func setFreeSequence():
	tl_target.stopTrying()
	bl_target.stopTrying()
	tr_target.stopTrying()
	br_target.stopTrying()
	
	cpu_particles_2d.emitting = true
	swirl_enemy.free()
	collision_polygon_2d.free()
	timer.start()

func _on_timer_timeout():
	queue_free()
