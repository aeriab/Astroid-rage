extends Node

const RED_ENEMY = preload("res://scenes/redEnemy.tscn")

@export var wave1RedEnemyNum: int
@export var wave2RedEnemyNum: int
@export var wave3RedEnemyNum: int

@onready var wave_1_timer = $Wave1Timer
@onready var wave_2_timer = $Wave2Timer
@onready var wave_3_timer = $Wave3Timer


func _on_wave_1_timer_timeout():
	print("starting wave")
	var i = 0
	while i < wave1RedEnemyNum:
		var enemy1 = RED_ENEMY.instantiate()
		enemy1.spawn()
		get_parent().add_child.call_deferred(enemy1)
		i += 1
	
