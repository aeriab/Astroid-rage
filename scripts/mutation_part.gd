extends Node2D
@onready var tank_bird_nose = $SnoutPosition/TankBirdNose
@onready var bird_eyelid = $BirdEyelid
@onready var tank_bird_pupil = $TankBirdPupil
@onready var snout_position = $SnoutPosition


func noseScale():
	return tank_bird_nose.scale.x

func scaleNose(num):
	tank_bird_nose.scale.x = num

func scaleEyelid(num):
	bird_eyelid.scale.x = num

func scalePupil(num):
	tank_bird_pupil.scale.x = num
	tank_bird_pupil.scale.y = num

func snoutPositionX():
	return snout_position.global_position.x

func snoutPositionY():
	return snout_position.global_position.y
