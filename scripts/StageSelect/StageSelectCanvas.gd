extends CanvasLayer

var stageSelecting: int
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



@onready var dark_star_particle_1 = $"../DarkStarParticle"
@onready var star_particle_1 = $"../DarkStarParticle/StarParticle1"
@onready var dark_star_particle_2 = $"../DarkStarParticle2"
@onready var star_particle_2 = $"../DarkStarParticle2/StarParticle2"
@onready var dark_star_particle_3 = $"../DarkStarParticle3"
@onready var star_particle_3 = $"../DarkStarParticle3/StarParticle3"
@onready var dark_star_particle_4 = $"../DarkStarParticle4"
@onready var star_particle_4 = $"../DarkStarParticle4/StarParticle4"
@onready var dark_star_particle_5 = $"../DarkStarParticle5"
@onready var star_particle_5 = $"../DarkStarParticle5/StarParticle5"
@onready var dark_star_particle_6 = $"../DarkStarParticle6"
@onready var star_particle_6 = $"../DarkStarParticle6/StarParticle6"
@onready var dark_star_particle_7 = $"../DarkStarParticle7"
@onready var star_particle_7 = $"../DarkStarParticle7/StarParticle7"




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
	
	
	#Global.unspentPoints = Global.Stage1StarsAchieved + Global.Stage2StarsAchieved + Global.Stage3StarsAchieved + Global.Stage4StarsAchieved - (bupgrade_1.star_count+bupgrade_2.star_count+bupgrade_3.star_count+bupgrade_4.star_count+bupgrade_5.star_count + dupgrade_1.star_count+dupgrade_2.star_count+dupgrade_3.star_count+dupgrade_4.star_count+dupgrade_5.star_count)
	Global.unspentPoints = 50
	
	if Global.current_stage == "Learner Lagoon":
		stageSelecting = 1
	elif Global.current_stage == "Perfect Pond":
		stageSelecting = 2
	elif Global.current_stage == "Giga Geyser":
		stageSelecting = 3
	elif Global.current_stage == "Swirly Swamp":
		stageSelecting = 4

func resetStarParticles():
	star_particle_1.visible = false
	star_particle_2.visible = false
	star_particle_3.visible = false
	star_particle_4.visible = false
	star_particle_5.visible = false
	star_particle_6.visible = false
	star_particle_7.visible = false

func _process(_delta):
	checkBaseStars()
	checkDroneStars()
	upgrades_left_label.text = "UPGRADES\nLEFT: " + str(Global.unspentPoints)
	
	if stageSelecting == 1:
		Global.waveNum = 3
		Global.current_stage = "Learner Lagoon"
		stage_words.text = "Stage 1: Learner Lagoon"
		left_stage_arrow.visible = false
		resetStarParticles()
		if Global.Stage1StarsAchieved >= 1:
			star_particle_3.visible = true
		if Global.Stage1StarsAchieved >= 2:
			star_particle_4.visible = true
		if Global.Stage1StarsAchieved >= 3:
			star_particle_5.visible = true
	elif stageSelecting == 2:
		Global.waveNum = 3
		Global.current_stage = "Perfect Pond"
		stage_words.text = "Stage 2: Perfect Pond"
		resetStarParticles()
		if Global.Stage2StarsAchieved >= 1:
			star_particle_3.visible = true
		if Global.Stage2StarsAchieved >= 2:
			star_particle_4.visible = true
		if Global.Stage2StarsAchieved >= 3:
			star_particle_5.visible = true
	elif stageSelecting == 3:
		Global.waveNum = 5
		Global.current_stage = "Giga Geyser"
		stage_words.text = "Stage 3: Giga Geyser"
		resetStarParticles()
		if Global.Stage3StarsAchieved >= 1:
			star_particle_2.visible = true
		if Global.Stage3StarsAchieved >= 2:
			star_particle_3.visible = true
		if Global.Stage3StarsAchieved >= 3:
			star_particle_4.visible = true
		if Global.Stage3StarsAchieved >= 4:
			star_particle_5.visible = true
		if Global.Stage3StarsAchieved >= 5:
			star_particle_6.visible = true
	elif stageSelecting == 4:
		Global.waveNum = 7
		Global.current_stage = "Swirly Swamp"
		stage_words.text = "Stage 4: Swirly Swamp"
		right_stage_arrow.visible = false
		resetStarParticles()
		if Global.Stage4StarsAchieved >= 1:
			star_particle_1.visible = true
		if Global.Stage4StarsAchieved >= 2:
			star_particle_2.visible = true
		if Global.Stage4StarsAchieved >= 3:
			star_particle_3.visible = true
		if Global.Stage4StarsAchieved >= 4:
			star_particle_4.visible = true
		if Global.Stage4StarsAchieved >= 5:
			star_particle_5.visible = true
		if Global.Stage4StarsAchieved >= 6:
			star_particle_6.visible = true
		if Global.Stage4StarsAchieved >= 7:
			star_particle_7.visible = true
	
	if Global.waveNum == 3:
		dark_star_particle_1.visible = false
		dark_star_particle_2.visible = false
		dark_star_particle_6.visible = false
		dark_star_particle_7.visible = false
	elif Global.waveNum == 5:
		dark_star_particle_1.visible = false
		dark_star_particle_2.visible = true
		dark_star_particle_6.visible = true
		dark_star_particle_7.visible = false
	elif Global.waveNum == 7:
		dark_star_particle_1.visible = true
		dark_star_particle_2.visible = true
		dark_star_particle_6.visible = true
		dark_star_particle_7.visible = true


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




























