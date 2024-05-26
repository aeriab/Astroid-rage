extends Node

const SQUARE_NODE = preload("res://scenes/square_xp_node.tscn")
const HEALTH_NODE = preload("res://scenes/health_node.tscn")

@onready var square_create_timer = $SquareCreateTimer
@onready var health_create_timer = $HealthCreateTimer

func _ready():
	square_create_timer.wait_time = Global.squareWaitTime
	health_create_timer.wait_time = Global.healthWaitTime

func _physics_process(_delta):
	if Global.xpNodesOnScreen < 50 && square_create_timer.is_stopped():
		square_create_timer.start()
	if Global.xpNodesOnScreen < 50 && health_create_timer.is_stopped():
		health_create_timer.start()

func _on_square_create_timer_timeout():
	square_create_timer.stop()
	spawnSquares()

func spawnSquares():
	Global.xpNodesOnScreen += 1
	var squareNode = SQUARE_NODE.instantiate()
	squareNode.sizeOfNode = randf_range(0.5,1.5)
	get_parent().add_child.call_deferred(squareNode)

func _on_health_create_timer_timeout():
	health_create_timer.stop()
	spawnHealth()

func spawnHealth():
	Global.xpNodesOnScreen += 1
	var healthNode = HEALTH_NODE.instantiate()
	healthNode.sizeOfNode = randf_range(0.5,1.5)
	get_parent().add_child.call_deferred(healthNode)



