extends Node

var squareWaitTime = 3.1
var healthWaitTime = 12.0
var xpNodesOnScreen = 0
var level = 1

var enemyNum = 0

var bulletSize = 2
var bulletSpeed = 2
var damage = 4
var rotationSpeed = 3

var totalPoints = 40
var unspentPoints = 40

var xpAmount = 0.0

var player_health = 100.0

var popup_shouldbe_visible: bool = true

var difficulty: float = 1.0
var wave_progress: float = 100.0
var prior_dir: float = 1.0

func addXP(num):
	xpAmount += num * difficulty
	if xpAmount >= 6.28:
		xpAmount = xpAmount - 6.28
		level += 1
		unspentPoints += 1
		popup_shouldbe_visible = true
		difficulty -= difficulty * 0.1

func resetStats():
	bulletSize = 2
	bulletSpeed = 2
	damage = 4
	rotationSpeed = 3
	level = 1
	xpAmount = 0.0
	player_health = 100.0
	difficulty = 1.0
	xpNodesOnScreen = 0
	enemyNum = 0
	totalPoints = 0
	unspentPoints = 0
	popup_shouldbe_visible = false

func decreaseHealth(num):
	player_health -= num * 31.0

func decreaseEnemyNum():
	enemyNum -= 1
	wave_progress -= 5.0
