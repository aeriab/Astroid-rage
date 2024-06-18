extends Node2D
@onready var star_particle_1 = $StarCompletes/StarParticle1
@onready var star_particle_2 = $StarCompletes/StarParticle2
@onready var star_particle_3 = $StarCompletes/StarParticle3
@onready var star_particle_4 = $StarCompletes/StarParticle4
@onready var star_particle_5 = $StarCompletes/StarParticle5
@onready var star_particle_6 = $StarCompletes/StarParticle6
@onready var star_particle_7 = $StarCompletes/StarParticle7

func _ready():
	if Global.popHighscore >= Global.popS1:
		star_particle_1.visible = true
	if Global.popHighscore >= Global.popS2:
		star_particle_2.visible = true
	if Global.popHighscore >= Global.popS3:
		star_particle_3.visible = true
	if Global.popHighscore >= Global.popS4:
		star_particle_4.visible = true
	if Global.popHighscore >= Global.popS5:
		star_particle_5.visible = true
	if Global.popHighscore >= Global.popS6:
		star_particle_6.visible = true
	if Global.popHighscore >= Global.popS7:
		star_particle_7.visible = true
	

