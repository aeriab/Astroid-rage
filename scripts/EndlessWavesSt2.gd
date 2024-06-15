extends Node

const RED_ENEMY = preload("res://scenes/redEnemy.tscn")

var time: float = 0.0
var next_time: float = 0.0
var progress: float = 0.0
var enSpeed: float = 1.0

const e: float = 2.718281828459

var randomEnNum: int

func _ready():
	next_time = randf_range(1.0, 2.0)
	Global.rotationSpeed = log(progress + 2) / log(e) + 1.5
	Global.bulletSpeed = log(progress + 2) / log(e) + 1.0

func _process(delta):
	time += delta * Global.gameTimeScale
	
	if time >= next_time:
		spawnTargetEnemy()
		Global.gameTimeScale += 0.008
		next_time = randf_range(1.0,2.5)
		time = 0.0

func spawnTargetEnemy():
	var enemy = RED_ENEMY.instantiate()
	enemy.spawn(randf_range(1.0,1.5))
	get_parent().add_child.call_deferred(enemy)
