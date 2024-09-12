extends Node2D
@onready var snout_position = $SnoutPosition
@onready var but_parts = $butParts

@onready var ball_play_sprite = $"../BallPlaySprite"

func snoutPositionX():
	return snout_position.global_position.x

func snoutPositionY():
	return snout_position.global_position.y

func noseScale():
	return but_parts.scale.x

func scaleNose(num):
	but_parts.position.y = ((num - 1.0) * 80.0)

func setFire(_val):
	pass
	
