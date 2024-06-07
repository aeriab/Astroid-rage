extends Sprite2D
@onready var game_over = $"../GameOverSt1"

var dying: bool = false

func _process(_delta):
	material.set_shader_parameter("health_value",Global.player_health)
	if Global.player_health <= 0:
		dying = true
		game_over.visible = true
	
	if dying:
		Engine.time_scale = Engine.time_scale - 0.01
		if Engine.time_scale <= 0:
			Engine.time_scale = 0
			dying = false
