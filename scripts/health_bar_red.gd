extends Sprite2D

func _process(_delta):
	material.set_shader_parameter("health_value",Global.player_health)
