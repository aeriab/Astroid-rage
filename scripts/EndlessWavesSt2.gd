extends Node

const RED_ENEMY = preload("res://scenes/enemy_scenes/redEnemy.tscn")
const PURPLE_BOSS = preload("res://scenes/enemy_scenes/purple_worm.tscn")

var time: float = 0.0
var next_time: float = 0.0
var progress: float = 0.0
var enSpeed: float = 1.0

const e: float = 2.718281828459

var randomEnNum: int

var bossTime: float = 0.0
var next_boss_time: float

func _ready():
	next_time = randf_range(1.0, 2.0)
	next_boss_time = randf_range(10.0,12.0)
	Global.rotationSpeed = log(progress + 2) / log(e) + 1.5
	Global.bulletSpeed = log(progress + 2) / log(e) + 1.0

func _process(delta):
	time += delta * Global.gameTimeScale
	
	if time >= next_time:
		spawnEnemyGroup()
		Global.gameTimeScale += 0.05
		next_time = randf_range(6.0,12.0)
		time = 0.0
	
	bossTime += delta * Global.gameTimeScale
	
	if bossTime >= next_boss_time:
		spawnEnemyBoss()
		Global.gameTimeScale += 0.05
		next_boss_time = randf_range(15.0,30.0)
		bossTime = 0.0

func spawnTargetEnemy():
	var enemy = RED_ENEMY.instantiate()
	enemy.spawn(randf_range(1.0,1.5))
	get_parent().add_child.call_deferred(enemy)

func spawnSpecific(sze,x1,y1):
	var enemy = RED_ENEMY.instantiate()
	enemy.spawn(sze,x1,y1,flipSprite)
	get_parent().add_child.call_deferred(enemy)

var bossConst: float = 3

func spawnEnemyBoss():
	x = randf_range(0,outerBoundX * bossConst)
	if x < innerBoundX * bossConst:
		y = randf_range(innerBoundY * bossConst,outerBoundY * bossConst)
	else:
		y = randf_range(0,outerBoundY * bossConst)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	var enemy = PURPLE_BOSS.instantiate()
	enemy.spawn(randf_range(7.0,10.0),x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

var innerBoundX = 5000
var innerBoundY = 5000
var outerBoundX = 6000
var outerBoundY = 6000

var globRadius: float = 0

var x: float = 0
var y: float = 0

var flipSprite: float = 0

func spawnEnemyGroup():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	globRadius = randf_range(2500.0,1000.0)
	
	var i = 0
	while i < int(globRadius / 100):
		spawnSpecific(randf_range(0.7,1.4),x + randf_range(-globRadius,globRadius),y + randf_range(-globRadius,globRadius))
		i += 1

