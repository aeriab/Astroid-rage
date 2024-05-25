extends Sprite2D


func _process(delta):
	material.set_shader_parameter("alpha_value",(Global.damage - 4) / 14.0)
