extends Node

const SQUARE_NODE = preload("res://scenes/square_xp_node.tscn")
@onready var square_create_timer = $SquareCreateTimer



func _on_square_create_timer_timeout():
	square_create_timer.stop()
	spawnSquares()

func spawnSquares():
	var squareNode = SQUARE_NODE.instantiate()
	get_parent().add_child.call_deferred(squareNode)
