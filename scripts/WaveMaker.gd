extends Node

const RED_ENEMY = preload("res://scenes/redEnemy.tscn")
const PURPLE_ENEMY = preload("res://scenes/purple_worm.tscn")
const SWIRL_ENEMY = preload("res://scenes/swirl_enemy.tscn")
const ZAG_ENEMY = preload("res://scenes/zag_enemy.tscn")

var difficulty: float = 1.0
var time: float = 0.0
var next_time: float = 0.0

var randomEnNum: int

func _ready():
	next_time = randf_range(1.0, 2.0)

func _process(delta):
	time += delta
	
	if time >= next_time:
		randomEnNum = randi_range(0,99)
		if randomEnNum <= 40:
			spawnRedEnemy()
		elif randomEnNum <= 65:
			spawnSwirlEnemy()
		elif randomEnNum <= 85:
			spawnPurpleEnemy()
		elif randomEnNum <= 99:
			spawnZagEnemy()
		difficulty += 0.05
		next_time = randf_range(1.0 / difficulty, 2.0 / difficulty)
		time = 0.0

var innerBoundX = 5000
var innerBoundY = 5000
var outerBoundX = 6000
var outerBoundY = 6000

var globRadius: float = 0

var x: float = 0
var y: float = 0

var flipSprite: float = 0

func spawnRedEnemy():
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
	
	var enemy = RED_ENEMY.instantiate()
	enemy.spawn(randf_range(0.8,1.6),x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

func spawnPurpleEnemy():
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
	
	var enemy = PURPLE_ENEMY.instantiate()
	enemy.spawn(randf_range(1.0,2.0),x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

func spawnSwirlEnemy():
	var enemy = SWIRL_ENEMY.instantiate()
	enemy.spawn(difficulty)
	get_parent().add_child.call_deferred(enemy)

func spawnZagEnemy():
	var enemy = ZAG_ENEMY.instantiate()
	enemy.spawn(difficulty)
	get_parent().add_child.call_deferred(enemy)
