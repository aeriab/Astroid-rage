extends Node2D

@onready var star_particle = $"../StarParticle"

func _process(_delta):
	material.set_shader_parameter("wave_progress",Global.firstWaveProgress)
	print(Global.firstWaveProgress)
	if Global.firstWaveProgress > 100:
		star_particle.visible = true
