extends Area2D

var clockwise = 1
var SPEED = Global.rotationSpeed
@export var pause_rot: bool
@export var starting_rot: float

func _ready():
	rotation = (starting_rot / 360) * 2 * PI

func _physics_process(delta):
	if Input.is_action_just_pressed("switch"):
		clockwise *= -1
	if !pause_rot:
		rotation += (SPEED * clockwise * delta)

func _on_area_entered(area):
	#print(str(area))
	pass
