extends Sprite2D

func _process(delta):
	material.set_shader_parameter("wave_progress",Global.wave_progress)
