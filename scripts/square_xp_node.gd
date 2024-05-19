extends Area2D

var x = 5000
var y = 5000

var innerBoundX = 500
var innerBoundY = 500
var outerBoundX = 3900
var outerBoundY = 2000

var xpAmount: float
var damage_value = 0.0
var damage_chunk = Global.damage * 0.1

var sizeOfNode: float

@onready var square_xp_node_2 = $SquareXpNode2

# Called when the node enters the scene tree for the first time.
func _ready():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
	if randi_range(0,1) == 1:
		y = -y
	rotation = randf_range(0,2*PI)
	scale.x = sizeOfNode
	scale.y = sizeOfNode
	damage_chunk = Global.damage / (pow(sizeOfNode,2) * 10) 
	xpAmount = 1.0 * pow(sizeOfNode,2)
	position = Vector2(x,y)

func addDamage():
	damage_value += damage_chunk
	if damage_value >= 0.9:
		breakXPNode()
	square_xp_node_2.modulate.a += -0.15
	square_xp_node_2.modulate.r += 0.15
	square_xp_node_2.modulate.g += -0.15
	square_xp_node_2.modulate.b += -0.15

func breakXPNode():
	Global.addXP(xpAmount)
	Global.xpNodesOnScreen += -1
	queue_free()

func _on_area_entered(area):
	if area.name.substr(0,1) == "@" || area.name.substr(0,1) == "B":
		area.free()
		addDamage()
