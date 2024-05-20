extends Node

signal xpGoingUp
var xpNodesOnScreen = 0
var level = 1

var upgradePhase: bool = false

var enemyNum = 0

var bulletSize = 2
var bulletSpeed = 3
var damage = 4
var rotationSpeed = 3

var totalPoints = 0
var unspentPoints = 0

var xpAmount = 0.0

var player_health = 100.0

func addXP(num):
	emit_signal("xpGoingUp")
	xpAmount += num
	if xpAmount >= 6.28:
		xpAmount = xpAmount - 6.28
		level += 1
		unspentPoints += 1
		upgradePopUp()

func upgradePopUp():
	upgradePhase = true
	Engine.time_scale = 0.0

func decreaseHealth(num):
	player_health -= num * 31.0

func decreaseEnemyNum():
	enemyNum -= 1
	
	#if enemyNum <= 0:
		#call_deferred("openStore")

func openStore():
	totalPoints += 1
	unspentPoints += 1
	get_tree().change_scene_to_file("res://scenes/store_page.tscn")

func endGame():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
