extends Node

var originalEnNum = 10
var enemyNum = 10

var bulletSize = 2
var bulletSpeed = 3
var damage = 4
var rotationSpeed = 3

var totalPoints = 0
var unspentPoints = 0

func decreaseEnemyNum():
	enemyNum -= 1
	
	if enemyNum <= 0:
		call_deferred("openStore")

func openStore():
	totalPoints += 1
	unspentPoints += 1
	get_tree().change_scene_to_file("res://scenes/store_page.tscn")

func endGame():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
