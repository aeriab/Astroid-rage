extends Node2D
@onready var star_particle_1 = $StarCompletes/StarParticle1
@onready var star_particle_2 = $StarCompletes/StarParticle2
@onready var star_particle_3 = $StarCompletes/StarParticle3
@onready var star_particle_4 = $StarCompletes/StarParticle4
@onready var star_particle_5 = $StarCompletes/StarParticle5
@onready var star_particle_6 = $StarCompletes/StarParticle6
@onready var star_particle_7 = $StarCompletes/StarParticle7

func _ready():
	if Global.autoHighscore >= Global.autoS1:
		star_particle_1.visible = true
	if Global.autoHighscore >= Global.autoS2:
		star_particle_2.visible = true
	if Global.autoHighscore >= Global.autoS3:
		star_particle_3.visible = true
	if Global.autoHighscore >= Global.autoS4:
		star_particle_4.visible = true
	if Global.autoHighscore >= Global.autoS5:
		star_particle_5.visible = true
	if Global.autoHighscore >= Global.autoS6:
		star_particle_6.visible = true
	if Global.autoHighscore >= Global.autoS7:
		star_particle_7.visible = true
