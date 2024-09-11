extends Node2D
@onready var snout_position = $SnoutPosition
@onready var mark_nose = $MarkNose
@onready var mark_eye_1 = $MarkEye1
@onready var mark_eye_2 = $MarkEye2

func snoutPositionX():
	return snout_position.global_position.x

func snoutPositionY():
	return snout_position.global_position.y

func noseScale():
	return mark_nose.scale.x

func scaleNose(num):
	mark_nose.scale.x = 0.504 + ((num - 1.0) * 0.25)

func setFire(_val):
	pass
	
