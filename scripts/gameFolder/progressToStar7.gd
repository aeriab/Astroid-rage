extends Node2D
@onready var star_particle = $"../StarParticle"
func _process(_delta):
	material.set_shader_parameter("wave_progress",Global.seventhWaveProgress)
	if Global.seventhWaveProgress > 100:
		star_particle.visible = true
