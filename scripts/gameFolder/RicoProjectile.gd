extends Sprite2D
@onready var rico_ball = $".."

func _ready():
	
	material.set_shader_parameter("expected_bounces",rico_ball.expectedBounces)
	
	if rico_ball.softShot:
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

func _process(_delta):
	material.set_shader_parameter("rico_bounces",rico_ball.bouncesLeft)
