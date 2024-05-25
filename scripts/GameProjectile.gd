extends Sprite2D

func _ready():
	material.set_shader_parameter("player_damage",Global.damage)
