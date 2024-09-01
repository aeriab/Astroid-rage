extends Node2D
@onready var star_particle = $"../StarParticle"
func _process(_delta):
	material.set_shader_parameter("wave_progress",Global.secondWaveProgress)
	if Global.secondWaveProgress > 100:
		star_particle.visible = true
