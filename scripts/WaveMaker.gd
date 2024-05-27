extends Node

const RED_ENEMY = preload("res://scenes/redEnemy.tscn")
const SPIRAL_ENEMY = preload("res://scenes/spiral_enemy.tscn")
const SWIRL_ENEMY = preload("res://scenes/swirl_enemy.tscn")

var difficulty: float = 1.0
var time: float = 0.0
var next_time: float = 0.0

var randomEnNum: int

func _ready():
	next_time = randf_range(1.0, 2.0)

func _process(delta):
	time += delta
	
	if time >= next_time:
		randomEnNum = randi_range(0,2)
		if randomEnNum == 0:
			spawnRedEnemy()
		elif randomEnNum == 1:
			spawnSwirlEnemy()
		else:
			spawnSpiralEnemy()
		difficulty += 0.05
		next_time = randf_range(1.5, 7.0)
		time = 0.0

func spawnRedEnemy():
	var enemy = RED_ENEMY.instantiate()
	enemy.spawn(difficulty)
	get_parent().add_child.call_deferred(enemy)

func spawnSpiralEnemy():
	var enemy = SPIRAL_ENEMY.instantiate()
	enemy.spawn(difficulty)
	get_parent().add_child.call_deferred(enemy)

func spawnSwirlEnemy():
	var enemy = SWIRL_ENEMY.instantiate()
	enemy.spawn(difficulty)
	get_parent().add_child.call_deferred(enemy)
