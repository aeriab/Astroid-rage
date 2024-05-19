extends Node

const RED_ENEMY = preload("res://scenes/redEnemy.tscn")

var curWaveSpawning = 1

@export var wave1RedEnemyNum: int
@export var wave2RedEnemyNum: int
@export var wave3RedEnemyNum: int

@onready var wave_1_timer = $Wave1Timer
@onready var wave_2_timer = $Wave2Timer
@onready var wave_3_timer = $Wave3Timer

func _process(_delta):
	if (Global.enemyNum == 0 && wave_1_timer.is_stopped() && wave_2_timer.is_stopped() && wave_3_timer.is_stopped()):
		curWaveSpawning += 1
		if curWaveSpawning == 2:
			wave_2_timer.start()
		elif curWaveSpawning == 3:
			wave_3_timer.start()

func _on_wave_1_timer_timeout():
	print("starting wave 1")
	spawnEnemies(wave1RedEnemyNum)
	wave_1_timer.stop()

func spawnEnemies(num):
	var i = 0
	while i < num:
		var enemy1 = RED_ENEMY.instantiate()
		enemy1.spawn()
		get_parent().add_child.call_deferred(enemy1)
		i += 1


func _on_wave_2_timer_timeout():
	print("starting wave 2")
	spawnEnemies(wave2RedEnemyNum)
	wave_2_timer.stop()

func _on_wave_3_timer_timeout():
	print("starting wave 3")
	spawnEnemies(wave3RedEnemyNum)
	wave_3_timer.stop()
