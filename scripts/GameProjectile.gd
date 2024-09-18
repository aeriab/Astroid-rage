extends Sprite2D

@onready var booger_area = $".."

func _ready():
	
	if booger_area.softShot:
		material.set_shader_parameter("opacity_value",25)
	
	if Global.damage >= 14:
		material.set_shader_parameter("player_damage",Global.nextBoogColor)
		Global.nextBoogColor += (0.3) * Global.direction
		if Global.nextBoogColor >= 14.5 && Global.direction == 1:
			Global.direction = -1
		elif Global.nextBoogColor <= 0.5 && Global.direction == -1:
			Global.direction = 1
	else:
		material.set_shader_parameter("player_damage",Global.damage * 1.2)
