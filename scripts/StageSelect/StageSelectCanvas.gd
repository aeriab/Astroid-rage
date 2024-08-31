extends CanvasLayer

var stageSelecting: int = 1
var MAX_STAGE: int = 4
@onready var stage_words = $StageWords
@onready var left_stage_arrow = $LeftStageArrow
@onready var right_stage_arrow = $RightStageArrow
@onready var upgrades_left_label = $UpgradesLeftLabel

#######################################################################################################

@onready var star1_particle_1 = $BaseUpgrades/upgrade_1/StarParticle1
@onready var star1_particle_2 = $BaseUpgrades/upgrade_1/StarParticle2
@onready var star1_particle_3 = $BaseUpgrades/upgrade_1/StarParticle3
@onready var star1_particle_4 = $BaseUpgrades/upgrade_1/StarParticle4
@onready var star1_particle_5 = $BaseUpgrades/upgrade_1/StarParticle5

@onready var star2_particle_1 = $BaseUpgrades/upgrade_2/StarParticle1
@onready var star2_particle_2 = $BaseUpgrades/upgrade_2/StarParticle2
@onready var star2_particle_3 = $BaseUpgrades/upgrade_2/StarParticle3
@onready var star2_particle_4 = $BaseUpgrades/upgrade_2/StarParticle4
@onready var star2_particle_5 = $BaseUpgrades/upgrade_2/StarParticle5

@onready var star3_particle_1 = $BaseUpgrades/upgrade_3/StarParticle1
@onready var star3_particle_2 = $BaseUpgrades/upgrade_3/StarParticle2
@onready var star3_particle_3 = $BaseUpgrades/upgrade_3/StarParticle3
@onready var star3_particle_4 = $BaseUpgrades/upgrade_3/StarParticle4
@onready var star3_particle_5 = $BaseUpgrades/upgrade_3/StarParticle5

@onready var star4_particle_1 = $BaseUpgrades/upgrade_4/StarParticle1
@onready var star4_particle_2 = $BaseUpgrades/upgrade_4/StarParticle2
@onready var star4_particle_3 = $BaseUpgrades/upgrade_4/StarParticle3
@onready var star4_particle_4 = $BaseUpgrades/upgrade_4/StarParticle4
@onready var star4_particle_5 = $BaseUpgrades/upgrade_4/StarParticle5

@onready var star5_particle_1 = $BaseUpgrades/upgrade_5/StarParticle1
@onready var star5_particle_2 = $BaseUpgrades/upgrade_5/StarParticle2
@onready var star5_particle_3 = $BaseUpgrades/upgrade_5/StarParticle3
@onready var star5_particle_4 = $BaseUpgrades/upgrade_5/StarParticle4
@onready var star5_particle_5 = $BaseUpgrades/upgrade_5/StarParticle5

#######################################################################################################

@onready var star1_dparticle_1 = $DroneUpgrades/upgrade_1/StarParticle1
@onready var star1_dparticle_2 = $DroneUpgrades/upgrade_1/StarParticle2
@onready var star1_dparticle_3 = $DroneUpgrades/upgrade_1/StarParticle3
@onready var star1_dparticle_4 = $DroneUpgrades/upgrade_1/StarParticle4
@onready var star1_dparticle_5 = $DroneUpgrades/upgrade_1/StarParticle5

@onready var star2_dparticle_1 = $DroneUpgrades/upgrade_2/StarParticle1
@onready var star2_dparticle_2 = $DroneUpgrades/upgrade_2/StarParticle2
@onready var star2_dparticle_3 = $DroneUpgrades/upgrade_2/StarParticle3
@onready var star2_dparticle_4 = $DroneUpgrades/upgrade_2/StarParticle4
@onready var star2_dparticle_5 = $DroneUpgrades/upgrade_2/StarParticle5

@onready var star3_dparticle_1 = $DroneUpgrades/upgrade_3/StarParticle1
@onready var star3_dparticle_2 = $DroneUpgrades/upgrade_3/StarParticle2
@onready var star3_dparticle_3 = $DroneUpgrades/upgrade_3/StarParticle3
@onready var star3_dparticle_4 = $DroneUpgrades/upgrade_3/StarParticle4
@onready var star3_dparticle_5 = $DroneUpgrades/upgrade_3/StarParticle5

@onready var star4_dparticle_1 = $DroneUpgrades/upgrade_4/StarParticle1
@onready var star4_dparticle_2 = $DroneUpgrades/upgrade_4/StarParticle2
@onready var star4_dparticle_3 = $DroneUpgrades/upgrade_4/StarParticle3
@onready var star4_dparticle_4 = $DroneUpgrades/upgrade_4/StarParticle4
@onready var star4_dparticle_5 = $DroneUpgrades/upgrade_4/StarParticle5

@onready var star5_dparticle_1 = $DroneUpgrades/upgrade_5/StarParticle1
@onready var star5_dparticle_2 = $DroneUpgrades/upgrade_5/StarParticle2
@onready var star5_dparticle_3 = $DroneUpgrades/upgrade_5/StarParticle3
@onready var star5_dparticle_4 = $DroneUpgrades/upgrade_5/StarParticle4
@onready var star5_dparticle_5 = $DroneUpgrades/upgrade_5/StarParticle5

#######################################################################################################

@onready var bupgrade_1 = $BaseUpgrades/upgrade_1
@onready var bupgrade_2 = $BaseUpgrades/upgrade_2
@onready var bupgrade_3 = $BaseUpgrades/upgrade_3
@onready var bupgrade_4 = $BaseUpgrades/upgrade_4
@onready var bupgrade_5 = $BaseUpgrades/upgrade_5

@onready var dupgrade_1 = $DroneUpgrades/upgrade_1
@onready var dupgrade_2 = $DroneUpgrades/upgrade_2
@onready var dupgrade_3 = $DroneUpgrades/upgrade_3
@onready var dupgrade_4 = $DroneUpgrades/upgrade_4
@onready var dupgrade_5 = $DroneUpgrades/upgrade_5

func _ready():
	bupgrade_1.star_count = Global.num_base_stars1
	bupgrade_2.star_count = Global.num_base_stars2
	bupgrade_3.star_count = Global.num_base_stars3
	bupgrade_4.star_count = Global.num_base_stars4
	bupgrade_5.star_count = Global.num_base_stars5
	
	dupgrade_1.star_count = Global.num_drone_stars1
	dupgrade_2.star_count = Global.num_drone_stars2
	dupgrade_3.star_count = Global.num_drone_stars3
	dupgrade_4.star_count = Global.num_drone_stars4
	dupgrade_5.star_count = Global.num_drone_stars5

func _process(_delta):
	checkBaseStars()
	checkDroneStars()
	upgrades_left_label.text = "UPGRADES\nLEFT: " + str(Global.unspentPoints)
	
	if stageSelecting == 1:
		stage_words.text = "Stage 1: Learner Lagoon"
		left_stage_arrow.visible = false
	elif stageSelecting == 2:
		stage_words.text = "Stage 2: Perfect Pond"
	elif stageSelecting == 3:
		stage_words.text = "Stage 3: Giga Geyser"
	elif stageSelecting == 4:
		stage_words.text = "Stage 4: Swirly Swamp"
		right_stage_arrow.visible = false


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/playable_scenes/game.tscn")


func _on_right_stage_arrow_pressed():
	left_stage_arrow.visible = true
	if stageSelecting < MAX_STAGE:
		stageSelecting += 1


func _on_left_stage_arrow_pressed():
	right_stage_arrow.visible = true
	if stageSelecting >= 2:
		stageSelecting -= 1

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/playable_scenes/home_menu.tscn")

func checkBaseStars():
	Global.num_base_stars1 = int(star1_particle_1.visible) + int(star1_particle_2.visible) + int(star1_particle_3.visible) + int(star1_particle_4.visible) + int(star1_particle_5.visible)
	Global.num_base_stars2 = int(star2_particle_1.visible) + int(star2_particle_2.visible) + int(star2_particle_3.visible) + int(star2_particle_4.visible) + int(star2_particle_5.visible)
	Global.num_base_stars3 = int(star3_particle_1.visible) + int(star3_particle_2.visible) + int(star3_particle_3.visible) + int(star3_particle_4.visible) + int(star3_particle_5.visible)
	Global.num_base_stars4 = int(star4_particle_1.visible) + int(star4_particle_2.visible) + int(star4_particle_3.visible) + int(star4_particle_4.visible) + int(star4_particle_5.visible)
	Global.num_base_stars5 = int(star5_particle_1.visible) + int(star5_particle_2.visible) + int(star5_particle_3.visible) + int(star5_particle_4.visible) + int(star5_particle_5.visible)


func checkDroneStars():
	Global.num_drone_stars1 = int(star1_dparticle_1.visible) + int(star1_dparticle_2.visible) + int(star1_dparticle_3.visible) + int(star1_dparticle_4.visible) + int(star1_dparticle_5.visible)
	Global.num_drone_stars2 = int(star2_dparticle_1.visible) + int(star2_dparticle_2.visible) + int(star2_dparticle_3.visible) + int(star2_dparticle_4.visible) + int(star2_dparticle_5.visible)
	Global.num_drone_stars3 = int(star3_dparticle_1.visible) + int(star3_dparticle_2.visible) + int(star3_dparticle_3.visible) + int(star3_dparticle_4.visible) + int(star3_dparticle_5.visible)
	Global.num_drone_stars4 = int(star4_dparticle_1.visible) + int(star4_dparticle_2.visible) + int(star4_dparticle_3.visible) + int(star4_dparticle_4.visible) + int(star4_dparticle_5.visible)
	Global.num_drone_stars5 = int(star5_dparticle_1.visible) + int(star5_dparticle_2.visible) + int(star5_dparticle_3.visible) + int(star5_dparticle_4.visible) + int(star5_dparticle_5.visible)




























