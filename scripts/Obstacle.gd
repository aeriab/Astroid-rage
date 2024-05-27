extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float

@onready var mutation_part = $mutationPart
@onready var mutation_part_2 = $mutationPart2

#@onready var tank_bird_nose = $SnoutPosition/TankBirdNose
#@onready var bird_eyelid = $BirdEyelid
#@onready var tank_bird_pupil = $TankBirdPupil

var eyelidHeight: float = 0.0

func _ready():
	rotation = (starting_rot / 360) * 2 * PI

func _physics_process(delta):
	if Global.mutateNumber >= 2:
		mutation_part_2.visible = true
	
	mutation_part.scaleEyelid(eyelidHeight)
	mutation_part_2.scaleEyelid(eyelidHeight)
	mutation_part.scalePupil(Global.bulletSpeed / 6.0 + 1.0)
	mutation_part_2.scalePupil(Global.bulletSpeed / 6.0 + 1.0)
	
	Global.prior_dir = clockwise
	if Input.is_action_just_pressed("switch"):
		clockwise *= -1
		if mutation_part.noseScale() < (Global.bulletSize / 8.0 + 0.5) * 2.0:
			mutation_part.scaleNose(mutation_part.noseScale() + Global.damage / 18.0)
		if mutation_part_2.noseScale() < (Global.bulletSize / 8.0 + 0.5) * 2.0:
			mutation_part_2.scaleNose(mutation_part_2.noseScale() + Global.damage / 18.0)
		
		
		if eyelidHeight <= 0.5:
			eyelidHeight += 0.3
		else:
			eyelidHeight = 0.5
	else:
		if mutation_part.noseScale() > Global.bulletSize / 8.0 + 0.5:
			mutation_part.scaleNose(mutation_part.noseScale() - (delta * 10.0))
		else:
			mutation_part.scaleNose(Global.bulletSize / 8.0 + 0.5)
		if mutation_part_2.noseScale() > Global.bulletSize / 8.0 + 0.5:
			mutation_part_2.scaleNose(mutation_part_2.noseScale() - (delta * 10.0))
		else:
			mutation_part_2.scaleNose(Global.bulletSize / 8.0 + 0.5)
		
		if eyelidHeight > 0:
			eyelidHeight -= delta * 0.5
	if !pause_rot:
		rotation += (Global.rotationSpeed * clockwise * delta)

