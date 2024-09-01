extends Node2D
func _process(_delta):
	material.set_shader_parameter("wave_progress",Global.sixthWaveProgress)
