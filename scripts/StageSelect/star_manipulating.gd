extends Node
@onready var star_particle_1 = $StarParticle1
@onready var star_particle_2 = $StarParticle2
@onready var star_particle_3 = $StarParticle3
@onready var star_particle_4 = $StarParticle4
@onready var star_particle_5 = $StarParticle5
@onready var up_minus = $upMinus
@onready var up_plus = $upPlus
@onready var main_canvas = $"../.."

var first_minus_press: bool = true
var first_plus_press: bool = true
var star_count: int = 0

func _process(_delta):
	if up_minus.button_pressed && first_minus_press:
		if star_count > 0:
			star_count -= 1
			Global.unspentPoints += 1
			main_canvas.checkBaseStars()
			main_canvas.checkDroneStars()
		first_minus_press = false
	
	if !up_minus.button_pressed && !first_minus_press:
		first_minus_press = true
	
	
	if up_plus.button_pressed && first_plus_press:
		if star_count < 5 && Global.unspentPoints > 0:
			star_count += 1
			Global.unspentPoints -= 1
			main_canvas.checkBaseStars()
			main_canvas.checkDroneStars()
		first_plus_press = false
	
	if !up_plus.button_pressed && !first_plus_press:
		first_plus_press = true
	
	if star_count >= 1:
		star_particle_1.visible = true
		up_minus.visible = true
	else:
		star_particle_1.visible = false
		up_minus.visible = false
	if star_count >= 2:
		star_particle_2.visible = true
	else:
		star_particle_2.visible = false
	if star_count >= 3:
		star_particle_3.visible = true
	else:
		star_particle_3.visible = false
	if star_count >= 4:
		star_particle_4.visible = true
	else:
		star_particle_4.visible = false
	if star_count >= 5:
		star_particle_5.visible = true
		up_plus.visible = false
	else:
		star_particle_5.visible = false
		up_plus.visible = true
	
	if Global.unspentPoints <= 0:
		up_plus.visible = false
