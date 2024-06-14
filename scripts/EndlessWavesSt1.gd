extends Node

const TARGET_ENEMY = preload("res://scenes/target_enemy.tscn")

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
		next_time = randf_range(2.0/enSpeed, 5.0/enSpeed)
		time = 0.0
		
		progress += 0.4
		Global.rotationSpeed = log(progress + 2) / log(e) + 1.5
		Global.bulletSpeed = log(progress + 2) / log(e) + 1.0
		enSpeed = log(progress + 2) / log(e)

func spawnTargetEnemy():
	var enemy = TARGET_ENEMY.instantiate()
	enemy.spawn(2.0,randf_range(enSpeed * 0.6,enSpeed * 1.4))
	get_parent().add_child.call_deferred(enemy)
