extends Node2D
@onready var ghost_particle = $GhostParticle


func _process(delta):
	material.set_shader_parameter("wave_progress",Global.firstWaveProgress)
