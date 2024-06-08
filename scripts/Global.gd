extends Node

var evoLevel: int = 2

var mutateNumber: int = 1
var barrelUpNumArray: Array = [1,0,0,0,0,0,0,0]
var evolutionPoints: int = 10

var squareWaitTime = 3.1
var healthWaitTime = 12.0
var xpNodesOnScreen = 0
var level = 1

var enemyNum = 0

var bulletSize = 2
var bulletSpeed: float = 2.0
var damage = 4
var rotationSpeed: float = 3.0

var totalPoints = 30
var unspentPoints = 30

var xpAmount = 0.0

var player_health = 100.0

var popup_shouldbe_visible: bool = true

var difficulty: float = 1.0
var wave_progress: float = 100.0
var prior_dir: float = 1.0

var firstEvolveCheck: bool = true

func addXP(num):
	xpAmount += num * difficulty
	if xpAmount >= 6.28:
		xpAmount = xpAmount - 6.28
		level += 1
		unspentPoints += 1
		popup_shouldbe_visible = true
		difficulty -= difficulty * 0.1
		if level % evoLevel == 0 && firstEvolveCheck == true:
			Global.evolutionPoints += 1
			firstEvolveCheck = false
		if level % evoLevel == 1:
			firstEvolveCheck = true

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
	mutateNumber = 1
	evolutionPoints = 0
	barrelUpNumArray = [1,0,0,0,0,0,0,0]

func decreaseHealth(num):
	player_health -= num * 31.0

func decreaseEnemyNum():
	enemyNum -= 1
	wave_progress -= 5.0
