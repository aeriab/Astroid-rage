extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float

@onready var mutation_part = $mutationPart
@onready var mutation_part_2 = $mutationPart2
@onready var mutation_part_3 = $mutationPart3
@onready var mutation_part_4 = $mutationPart4
@onready var mutation_part_5 = $mutationPart5
@onready var mutation_part_6 = $mutationPart6
@onready var mutation_part_7 = $mutationPart7
@onready var mutation_part_8 = $mutationPart8

@onready var mutation_array: Array = [mutation_part,mutation_part_2,mutation_part_3,mutation_part_4,mutation_part_5,mutation_part_6,mutation_part_7,mutation_part_8]

#@onready var tank_bird_nose = $SnoutPosition/TankBirdNose
#@onready var bird_eyelid = $BirdEyelid
#@onready var tank_bird_pupil = $TankBirdPupil

var eyelidHeight: float = 0.0

func _ready():
	rotation = (starting_rot / 360) * 2 * PI

func _physics_process(delta):
	var i: int = 1
	for indiv_mutation in mutation_array:
		if Global.mutateNumber >= i:
			indiv_mutation.visible = true
		indiv_mutation.scaleEyelid(eyelidHeight)
		indiv_mutation.scalePupil(Global.bulletSpeed / 6.0 + 1.0)
		i += 1
	
	Global.prior_dir = clockwise
	if Input.is_action_just_pressed("switch"):
		clockwise *= -1
		
		for indiv_mutation in mutation_array:
			if indiv_mutation.noseScale() < (Global.bulletSize / 8.0 + 0.5) * 2.0:
				indiv_mutation.scaleNose(indiv_mutation.noseScale() + Global.damage / 18.0)
		
		
		if eyelidHeight <= 0.5:
			eyelidHeight += 0.3
		else:
			eyelidHeight = 0.5
	else:
		for indiv_mutation in mutation_array:
			if indiv_mutation.noseScale() > Global.bulletSize / 8.0 + 0.5:
				indiv_mutation.scaleNose(indiv_mutation.noseScale() - (delta * 10.0))
			else:
				indiv_mutation.scaleNose(Global.bulletSize / 8.0 + 0.5)
		
		if eyelidHeight > 0:
			eyelidHeight -= delta * 0.5
	if !pause_rot:
		rotation += (Global.rotationSpeed * clockwise * delta)

