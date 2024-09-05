extends Sprite2D




func _ready():
	if Global.damage >= 14:
		material.set_shader_parameter("player_damage",Global.nextBoogColor)
		Global.nextBoogColor += (0.3) * Global.direction
		if Global.nextBoogColor >= 14.5 && Global.direction == 1:
			Global.direction = -1
		elif Global.nextBoogColor <= 0.5 && Global.direction == -1:
			Global.direction = 1
	else:
		material.set_shader_parameter("player_damage",Global.damage * 1.2)
