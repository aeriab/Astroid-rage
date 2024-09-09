extends CanvasLayer

@onready var star_1 = $Star1
@onready var star_2 = $Star2
@onready var star_3 = $Star3
@onready var star_4 = $Star4
@onready var star_5 = $Star5
@onready var star_6 = $Star6
@onready var star_7 = $Star7
@onready var star_particle1 = $Star1/StarParticle
@onready var star_particle2 = $Star2/StarParticle
@onready var star_particle3 = $Star3/StarParticle
@onready var star_particle4 = $Star4/StarParticle
@onready var star_particle5 = $Star5/StarParticle
@onready var star_particle6 = $Star6/StarParticle
@onready var star_particle7 = $Star7/StarParticle


func _ready():
	
	star_particle1.visible=false
	star_particle2.visible=false
	star_particle3.visible=false
	star_particle4.visible=false
	star_particle5.visible=false
	star_particle6.visible=false
	star_particle7.visible=false
	
	if Global.waveNum == 3:
		star_1.visible = false
		star_2.visible = false
		star_3.visible = true
		star_4.visible = true
		star_5.visible = true
		star_6.visible = false
		star_7.visible = false
	elif Global.waveNum == 5:
		star_1.visible = false
		star_2.visible = true
		star_3.visible = true
		star_4.visible = true
		star_5.visible = true
		star_6.visible = true
		star_7.visible = false
	elif Global.waveNum == 7:
		star_1.visible = true
		star_2.visible = true
		star_3.visible = true
		star_4.visible = true
		star_5.visible = true
		star_6.visible = true
		star_7.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
