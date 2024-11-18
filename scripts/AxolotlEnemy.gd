extends Area2D

var popupSize: float = 2.5

const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")
const DEFAULT_NOTIFICATION = preload("res://scenes/default_notification.tscn")


@onready var cpu_particles_2d = $CPUParticles2D
@onready var collision_shape_2d = $CollisionShape2D
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
@onready var splatcho_enemy = $SplatchoEnemy
var randEnSprite: int

var stopMoving: bool = false
var alreadyFree: bool = false

func _ready():
	cpu_particles_2d.scale_amount_min = 30.0 * sizeOfEnemy
	cpu_particles_2d.scale_amount_max = 45.0 * sizeOfEnemy
	cpu_particles_2d.amount = sizeOfEnemy * 3 + 10

func spawn(dif,xgiven,ygiven,flipgiven):
	difficulty = dif
	Global.enemyNum += 1
	enemyIndex = Global.enemyNum
	
	sizeOfEnemy = randf_range(0.8,1.5)
	
	xpAmount = sizeOfEnemy + pow(sizeOfEnemy,2.0)
	if sizeOfEnemy >= 1.49:
		sizeOfEnemy = 3.0
	scale.x = sizeOfEnemy
	scale.y = sizeOfEnemy
	damage_chunk = Global.damage / (pow(sizeOfEnemy,2) * 2)
	
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
	
	rotation = -theta + PI/2

@onready var tail = $SplatchoEnemy/Skeleton2D/Torso/Tail
@onready var end_tail = $SplatchoEnemy/Skeleton2D/Torso/Tail/End_Tail
@onready var torso = $SplatchoEnemy/Skeleton2D/Torso
@onready var head = $SplatchoEnemy/Skeleton2D/Torso/Head

func _physics_process(delta):
	
	if !alreadyFree:
		head.rotation = ((0.02) * sin(time_ellapsed * 1) * PI) - PI
		torso.rotation = ((0.01) * sin(time_ellapsed * 0.5) * PI) - PI/2
		tail.rotation = (0.15) * sin(time_ellapsed * 2.5) * PI
		end_tail.rotation = (0.3) * sin(time_ellapsed * 2.5) * PI
	
	if !stopMoving:
		x -= cos(theta) * SPEED * delta * Global.gameTimeScale
		y -= -sin(theta) * SPEED * delta * Global.gameTimeScale
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
		pointsNotif.establishText("+1 'LOTL SOUL",popupSize,Color.PINK,0.1,0.0,true)
		get_parent().add_child.call_deferred(pointsNotif)
		setFreeSequence()
		alreadyFree = true
	
	#scale.y = ((sin(time_ellapsed / sizeOfEnemy) * (sizeOfEnemy) * 0.2) + sizeOfEnemy) * flipSprite
	
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
					pointsNotif.establishText("+1 'LOTL SOUL",popupSize,Color.PINK,0.1,0.0,true)
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
			pointsNotif.establishText("+1 'LOTL SOUL",popupSize,Color.PINK,0.1,0.0,true)
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
			pointsNotif.establishText("+1 'LOTL SOUL",popupSize,Color.PINK,0.1,0.0,true)
			get_parent().add_child.call_deferred(pointsNotif)
			setFreeSequence()
			alreadyFree = true

func moveWithGob():
	x += Global.gobXMovement
	y += Global.gobYMovement
	position = Vector2(x,y)
	
	if !alreadyFree:
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
				pointsNotif.establishText("+1 'LOTL SOUL",popupSize,Color.PINK,0.1,0.0,true)
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
			pointsNotif.establishText("+1 'LOTL SOUL",popupSize,Color.PINK,0.1,0.0,true)
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
	Global.lotlSouls += 1
	Global.lotlKills += 1
	cpu_particles_2d.emitting = true
	splatcho_enemy.free()
	collision_shape_2d.free()
	timer.start()

func _on_timer_timeout():
	queue_free()
