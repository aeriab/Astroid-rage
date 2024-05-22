extends Node

const SQUARE_NODE = preload("res://scenes/square_xp_node.tscn")

@onready var square_create_timer = $SquareCreateTimer

func _physics_process(_delta):
	if Global.xpNodesOnScreen < 50 && square_create_timer.is_stopped():
		square_create_timer.start()

func _on_square_create_timer_timeout():
	square_create_timer.stop()
	square_create_timer.wait_time = (Global.xpNodesOnScreen / 5.0) + randf_range(0.1,(Global.xpNodesOnScreen / 5.0) + 0.3)
	spawnSquares()

func spawnSquares():
	Global.xpNodesOnScreen += 1
	var squareNode = SQUARE_NODE.instantiate()
	squareNode.sizeOfNode = randf_range(0.5,1.5)
	get_parent().add_child.call_deferred(squareNode)
