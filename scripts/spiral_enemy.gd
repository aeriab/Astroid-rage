extends Area2D

const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")
const DEFAULT_NOTIFICATION = preload("res://scenes/default_notification.tscn")

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

const SPEED = 130
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

var stopMoving: bool = false
var alreadyFree: bool = false

func _ready():
	randEnSprite = randi_range(0,100)
	if randEnSprite <= 33:
		spiral_enemy.texture = preload("res://assets/spiralEnemySprites/SpiralEnemy.png")
	elif randEnSprite <= 67:
		spiral_enemy.texture = preload("res://assets/spiralEnemySprites/SpiralEnemyBrow.png")
	else:
		spiral_enemy.texture = preload("res://assets/spiralEnemySprites/SpiralEnemyStar.png")
	
	cpu_particles_2d.scale_amount_min = 30.0 * sizeOfEnemy
	cpu_particles_2d.scale_amount_max = 45.0 * sizeOfEnemy
	cpu_particles_2d.amount = sizeOfEnemy * 3 + 10

func spawn(dif,xgiven,ygiven,flipgiven):
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
	
	rotation = -theta + PI
	scale.y = sizeOfEnemy * flipSprite

func _physics_process(delta):
	
	x -= cos(theta) * SPEED * delta * Global.gameTimeScale
	y -= -sin(theta) * SPEED * delta * Global.gameTimeScale
	
	scale.x = ((sin(time_ellapsed / sizeOfEnemy) * (sizeOfEnemy) * 0.2) + sizeOfEnemy)
	
	if !stopMoving:
		position = Vector2(x,y)
	else:
		moveWithGob()
	
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
	
	time_ellapsed += delta * 5 * Global.gameTimeScale
	if shader_alpha != 1.0:
		shader_alpha += FADE_SPEED * delta * Global.gameTimeScale
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

var points: float = 0.0

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
	shader_value = shader_value + (damage_chunk * 5)
	
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
		collision_shape_2d.disabled = true

func _on_area_entered(area):
	if area.is_in_group("BoogerArea"):
		if area.softShot:
			tickleDamage()
		else:
			addDamage()
		area.setFreeSequence()
	
	if area.is_in_group("Gob"):
		if Global.enemiesOnGob <= 50:
			Global.enemiesOnGob += 1.0
			stopMoving = true
		else:
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
	
	if area.is_in_group("Crasher"):
		if area.is_in_group("Fling"):
			area.bounceBack(position.x,position.y)
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
	 
	if area.is_in_group("Player"):
		if !alreadyFree:
			Global.decreaseHealth(sizeOfEnemy - (sizeOfEnemy * shader_value))
			Global.enemyNum -= 1
			setFreeSequence()
			alreadyFree = true

func setFreeSequence():
	cpu_particles_2d.emitting = true
	spiral_enemy.free()
	collision_shape_2d.free()
	collision_polygon_2d.free()
	timer.start()

func _on_timer_timeout():
	queue_free()



