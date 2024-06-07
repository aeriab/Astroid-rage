extends Node

const TARGET_ENEMY = preload("res://scenes/target_enemy.tscn")

var time: float = 0.0
var next_time: float = 0.0

var randomEnNum: int

func _ready():
	next_time = randf_range(1.0, 2.0)

func _process(delta):
	time += delta
	
	if time >= next_time:
		spawnTargetEnemy()
		next_time = randf_range(2.0, 5.0)
		time = 0.0

func spawnTargetEnemy():
	var enemy = TARGET_ENEMY.instantiate()
	enemy.spawn(2.0)
	get_parent().add_child.call_deferred(enemy)
