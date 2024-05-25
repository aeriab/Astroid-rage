extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float
@onready var tank_bird_nose = $SnoutPosition/TankBirdNose
@onready var bird_eyelid = $BirdEyelid

var eyelidHeight: float = 0.0

func _ready():
	rotation = (starting_rot / 360) * 2 * PI

func _physics_process(delta):
	tank_bird_nose.scale.x = Global.bulletSize / 8.0 + 0.5
	bird_eyelid.scale.x = eyelidHeight
	
	Global.prior_dir = clockwise
	if Input.is_action_just_pressed("switch"):
		clockwise *= -1
		if eyelidHeight <= 0.5:
			eyelidHeight += 0.3
		else:
			eyelidHeight = 0.5
	else:
		if eyelidHeight > 0:
			eyelidHeight -= delta * 0.5
	if !pause_rot:
		rotation += (Global.rotationSpeed * clockwise * delta)

