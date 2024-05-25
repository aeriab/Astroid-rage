extends Node

const RED_ENEMY = preload("res://scenes/redEnemy.tscn")

var difficulty: float = 1.0
var time: float = 0.0
var next_time: float = 0.0

func _ready():
	next_time = randf_range(3.0, 6.0)

func _process(delta):
	time += delta
	
	if time >= next_time:
		spawnEnemy()
		difficulty += 0.05
		next_time = randf_range(1.5, 7.0)
		time = 0.0

func spawnEnemy():
	var enemy1 = RED_ENEMY.instantiate()
	enemy1.spawn(difficulty)
	get_parent().add_child.call_deferred(enemy1)

func spawnEnemies(num):
	var i = 0
	while i < num:
		var enemy1 = RED_ENEMY.instantiate()
		enemy1.spawn(difficulty)
		get_parent().add_child.call_deferred(enemy1)
		i += 1
