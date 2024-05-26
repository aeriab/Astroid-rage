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

const XP_NOTIFICATION = preload("res://scenes/xp_notification.tscn")

@onready var health_node = $HealthNode

func areaName():
	return "HealthNode"

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
	xpAmount = pow(sizeOfNode,2)
	position = Vector2(x,y)

func addDamage():
	damage_value += damage_chunk
	if damage_value >= 0.9:
		breakXPNode()
		Global.player_health += sizeOfNode * 30.0
		if Global.player_health > 100.0:
			Global.player_health = 100.0
	health_node.modulate.a += -0.15
	health_node.modulate.r += -0.15
	health_node.modulate.g += 0.15
	health_node.modulate.b += -0.15

func breakXPNode():
	Global.addXP(xpAmount)
	Global.xpNodesOnScreen += -1
	var xpNotif = XP_NOTIFICATION.instantiate()
	xpNotif.position = Vector2 (x,y)
	xpNotif.getXPSize(xpAmount)
	get_parent().add_child.call_deferred(xpNotif)
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("BoogerArea"):
		area.free()
		addDamage()
