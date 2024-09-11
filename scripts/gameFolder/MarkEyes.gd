extends Sprite2D


func _process(_delta):
	material.set_shader_parameter("explosiveValue",(scale.x - 0.5) / 1.0)
