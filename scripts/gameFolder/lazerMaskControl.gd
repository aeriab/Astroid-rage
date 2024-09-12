extends Sprite2D

func _process(_delta):
	material.set_shader_parameter("mask_value",(position.x + 2950) / 61.5)
