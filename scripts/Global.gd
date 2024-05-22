extends Node

var xpNodesOnScreen = 0
var level = 1

var enemyNum = 0

var bulletSize = 2
var bulletSpeed = 2
var damage = 4
var rotationSpeed = 3

var totalPoints = 0
var unspentPoints = 0

var xpAmount = 0.0

var player_health = 100.0

var popup_shouldbe_visible: bool = false

func addXP(num):
	xpAmount += num
	if xpAmount >= 6.28:
		xpAmount = xpAmount - 6.28
		level += 1
		unspentPoints += 1
		popup_shouldbe_visible = true

func decreaseHealth(num):
	player_health -= num * 31.0

func decreaseEnemyNum():
	enemyNum -= 1
