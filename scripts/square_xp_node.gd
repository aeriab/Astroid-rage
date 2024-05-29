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

@onready var collision_shape_2d_2 = $CollisionShape2D2
@onready var timer = $Timer
@onready var cpu_particles_2d = $CPUParticles2D
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
	xpAmount = pow(sizeOfNode,2)
	position = Vector2(x,y)
	
	cpu_particles_2d.scale_amount_min = 30.0 * sizeOfNode
	cpu_particles_2d.scale_amount_max = 45.0 * sizeOfNode
	cpu_particles_2d.amount = sizeOfNode * 3 + 10

func addDamage():
	damage_value += damage_chunk
	square_xp_node_2.modulate.a += -0.15
	square_xp_node_2.modulate.r += 0.15
	square_xp_node_2.modulate.g += -0.05
	square_xp_node_2.modulate.b += -0.15
	if damage_value >= 0.9:
		breakXPNode()

func breakXPNode():
	Global.addXP(xpAmount)
	Global.xpNodesOnScreen += -1
	var xpNotif = XP_NOTIFICATION.instantiate()
	xpNotif.position = Vector2 (x,y)
	xpNotif.getXPSize(xpAmount)
	get_parent().add_child.call_deferred(xpNotif)
	setFreeSequence()

func _on_area_entered(area):
	if area.is_in_group("BoogerArea"):
		area.setFreeSequence()
		addDamage()

func setFreeSequence():
	cpu_particles_2d.emitting = true
	square_xp_node_2.free()
	collision_shape_2d_2.free()
	timer.start()

func _on_timer_timeout():
	queue_free()
