extends Sprite2D
@onready var game_over = $"../GameOver"

var dying: bool = false

func _process(delta):
	material.set_shader_parameter("health_value",Global.player_health)
	if Global.player_health <= 0:
		dying = true
		game_over.visible = true
	
	if dying:
		print("dying animation")
		Engine.time_scale = Engine.time_scale - 0.01
		if Engine.time_scale <= 0:
			Engine.time_scale = 0
			dying = false
