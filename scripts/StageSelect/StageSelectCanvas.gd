extends CanvasLayer

var stageSelecting: int
var MAX_STAGE: int = 10
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


@onready var dark_star_particle_1 = $DarkStarParticle
@onready var star_particle_1 = $DarkStarParticle/StarParticle1
@onready var dark_star_particle_2 = $DarkStarParticle2
@onready var star_particle_2 = $DarkStarParticle2/StarParticle2
@onready var dark_star_particle_3 = $DarkStarParticle3
@onready var star_particle_3 = $DarkStarParticle3/StarParticle3
@onready var dark_star_particle_4 = $DarkStarParticle4
@onready var star_particle_4 = $DarkStarParticle4/StarParticle4
@onready var dark_star_particle_5 = $DarkStarParticle5
@onready var star_particle_5 = $DarkStarParticle5/StarParticle5
@onready var dark_star_particle_6 = $DarkStarParticle6
@onready var star_particle_6 = $DarkStarParticle6/StarParticle6
@onready var dark_star_particle_7 = $DarkStarParticle7
@onready var star_particle_7 = $DarkStarParticle7/StarParticle7

@onready var base_select = $BaseSelect

@onready var drone_select = $DroneSelect


func _ready():
	if Global.Stage1StarsAchieved <= 0:
		Global.levelProgress = 1
	elif Global.Stage2StarsAchieved <= 0:
		Global.levelProgress = 2
	elif Global.Stage3StarsAchieved <= 0:
		Global.levelProgress = 3
	elif Global.Stage4StarsAchieved <= 0:
		Global.levelProgress = 4
	elif Global.Stage5StarsAchieved <= 0:
		Global.levelProgress = 5
	elif Global.Stage6StarsAchieved <= 0:
		Global.levelProgress = 6
	elif Global.Stage7StarsAchieved <= 0:
		Global.levelProgress = 7
	elif Global.Stage8StarsAchieved <= 0:
		Global.levelProgress = 8
	elif Global.Stage9StarsAchieved <= 0:
		Global.levelProgress = 9
	elif Global.Stage10StarsAchieved <= 0:
		Global.levelProgress = 10
	
	
	
	Global.startCrasher = false
	Global.crashStarted = false
	
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
	
	base_select.updateBaseName()
	drone_select.updateDroneName()
	
	Global.unspentPoints = (Global.Stage1StarsAchieved + Global.Stage2StarsAchieved + Global.Stage3StarsAchieved + Global.Stage4StarsAchieved + Global.Stage5StarsAchieved + Global.Stage6StarsAchieved + Global.Stage7StarsAchieved + Global.Stage8StarsAchieved + Global.Stage9StarsAchieved + Global.Stage10StarsAchieved) - (bupgrade_1.star_count+bupgrade_2.star_count+bupgrade_3.star_count+bupgrade_4.star_count+bupgrade_5.star_count + dupgrade_1.star_count+dupgrade_2.star_count+dupgrade_3.star_count+dupgrade_4.star_count+dupgrade_5.star_count)
	
	if Global.current_stage == "Learner Lagoon":
		stageSelecting = 1
	elif Global.current_stage == "Perfect Pond":
		stageSelecting = 2
	elif Global.current_stage == "Giga Geyser":
		stageSelecting = 3
	elif Global.current_stage == "Swirly Swamp":
		stageSelecting = 4
	elif Global.current_stage == "Offset Ocean":
		stageSelecting = 5
	elif Global.current_stage == "Serpent Sea":
		stageSelecting = 6
	elif Global.current_stage == "Baffle Bay":
		stageSelecting = 7
	elif Global.current_stage == "Conic Cove":
		stageSelecting = 8
	elif Global.current_stage == "Steamy Stream":
		stageSelecting = 9
	elif Global.current_stage == "Massive Marsh":
		stageSelecting = 10

func resetStarParticles():
	star_particle_1.visible = false
	star_particle_2.visible = false
	star_particle_3.visible = false
	star_particle_4.visible = false
	star_particle_5.visible = false
	star_particle_6.visible = false
	star_particle_7.visible = false

@onready var stage_1_sprites = $Stage1Sprites
@onready var stage_2_sprites = $Stage2Sprites
@onready var stage_3_sprites = $Stage3Sprites
@onready var stage_4_sprites = $Stage4Sprites
@onready var stage_5_sprites = $Stage5Sprites
@onready var stage_6_sprites = $Stage6Sprites
@onready var stage_7_sprites = $Stage7Sprites
@onready var stage_8_sprites = $Stage8Sprites
@onready var stage_9_sprites = $Stage9Sprites
@onready var stage_10_sprites = $Stage10Sprites
@onready var stage_select_back = $"../StageSelectBack"
const STAGE_SELECT_BACK_S_1 = preload("res://assets/StageSelectBack/StageSelectBackS1.png")
const STAGE_SELECT_BACK_S_2 = preload("res://assets/StageSelectBack/StageSelectBackS2.png")
const STAGE_SELECT_BACK_S_3 = preload("res://assets/StageSelectBack/StageSelectBackS3.png")
const STAGE_SELECT_BACK_S_4 = preload("res://assets/StageSelectBack/StageSelectBackS4.png")
const STAGE_SELECT_BACK_S_5 = preload("res://assets/StageSelectBack/StageSelectBackS5.png")
const STAGE_SELECT_BACK_S_6 = preload("res://assets/StageSelectBack/StageSelectBackS1.png")
const STAGE_SELECT_BACK_S_7 = preload("res://assets/StageSelectBack/StageSelectBackS4.png")
const STAGE_SELECT_BACK_S_8 = preload("res://assets/StageSelectBack/StageSelectBackS2.png")
const STAGE_SELECT_BACK_S_9 = preload("res://assets/StageSelectBack/StageSelectBackS5.png")
const STAGE_SELECT_BACK_S_10 = preload("res://assets/StageSelectBack/StageSelectBackS3.png")


func establish_arrows():
	if Global.levelProgress == stageSelecting:
		right_stage_arrow.visible = false
	else:
		right_stage_arrow.visible = true
	
	if stageSelecting == 1:
		left_stage_arrow.visible = false
	else:
		left_stage_arrow.visible = true
	

@onready var play_button = $PlayButton

var playAnimTheta: float = 0.0

func _process(delta):
	if Global.unspentPoints == 0:
		upgrades_left_label.visible = false
		
		playAnimTheta += 0.05
		if playAnimTheta >= 6.28318:
			playAnimTheta = 0
		
		play_button.scale.x = 1.0 + (sin(playAnimTheta) * 0.05)
		play_button.scale.y = 1.0 + (sin(playAnimTheta) * 0.05)
		
	else:
		
		play_button.scale.x = 1.0
		play_button.scale.y = 1.0
		
		upgrades_left_label.visible = true
	
	
	checkBaseStars()
	checkDroneStars()
	upgrades_left_label.text = "UPGRADES\nLEFT: " + str(Global.unspentPoints)
	
	if stageSelecting == 1:
		
		stage_1_sprites.visible = true
		stage_2_sprites.visible = false
		stage_3_sprites.visible = false
		stage_4_sprites.visible = false
		stage_select_back.texture = STAGE_SELECT_BACK_S_1
		
		Global.waveNum = 3
		Global.current_stage = "Learner Lagoon"
		stage_words.text = "Stage 1: Learner Lagoon"
		establish_arrows()
		resetStarParticles()
		
		Global.wave3Wait = 25.0
		Global.wave4Wait = 25.0
		Global.wave5Wait = 30.0
		
		if Global.Stage1StarsAchieved >= 1:
			star_particle_3.visible = true
		if Global.Stage1StarsAchieved >= 2:
			star_particle_4.visible = true
		if Global.Stage1StarsAchieved >= 3:
			star_particle_5.visible = true
	elif stageSelecting == 2:
		
		stage_1_sprites.visible = false
		stage_2_sprites.visible = true
		stage_3_sprites.visible = false
		stage_4_sprites.visible = false
		stage_select_back.texture = STAGE_SELECT_BACK_S_2
		
		Global.waveNum = 3
		Global.current_stage = "Perfect Pond"
		stage_words.text = "Stage 2: Perfect Pond"
		establish_arrows()
		resetStarParticles()
		if Global.Stage2StarsAchieved >= 1:
			star_particle_3.visible = true
		if Global.Stage2StarsAchieved >= 2:
			star_particle_4.visible = true
		if Global.Stage2StarsAchieved >= 3:
			star_particle_5.visible = true
	elif stageSelecting == 3:
		
		stage_1_sprites.visible = false
		stage_2_sprites.visible = false
		stage_3_sprites.visible = true
		stage_4_sprites.visible = false
		stage_select_back.texture = STAGE_SELECT_BACK_S_3
		
		Global.waveNum = 5
		Global.current_stage = "Giga Geyser"
		stage_words.text = "Stage 3: Giga Geyser"
		establish_arrows()
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
		hideStageSprites()
		stage_4_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_4
		Global.waveNum = 7
		Global.current_stage = "Swirly Swamp"
		Global.stage_index = 4
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
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
	elif stageSelecting == 5:
		hideStageSprites()
		stage_5_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_5
		Global.waveNum = 5
		Global.current_stage = "Offset Ocean"
		Global.stage_index = 5
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
		resetStarParticles()
		if Global.Stage5StarsAchieved >= 1:
			star_particle_2.visible = true
		if Global.Stage5StarsAchieved >= 2:
			star_particle_3.visible = true
		if Global.Stage5StarsAchieved >= 3:
			star_particle_4.visible = true
		if Global.Stage5StarsAchieved >= 4:
			star_particle_5.visible = true
		if Global.Stage5StarsAchieved >= 5:
			star_particle_6.visible = true
	elif stageSelecting == 6:
		hideStageSprites()
		stage_6_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_6
		Global.waveNum = 3
		Global.current_stage = "Serpent Sea"
		Global.stage_index = 6
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
		resetStarParticles()
		if Global.Stage6StarsAchieved >= 1:
			star_particle_3.visible = true
		if Global.Stage6StarsAchieved >= 2:
			star_particle_4.visible = true
		if Global.Stage6StarsAchieved >= 3:
			star_particle_5.visible = true
	elif stageSelecting == 7:
		hideStageSprites()
		stage_7_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_7
		Global.waveNum = 3
		Global.current_stage = "Baffle Bay"
		Global.stage_index = 7
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
		resetStarParticles()
		if Global.Stage7StarsAchieved >= 1:
			star_particle_3.visible = true
		if Global.Stage7StarsAchieved >= 2:
			star_particle_4.visible = true
		if Global.Stage7StarsAchieved >= 3:
			star_particle_5.visible = true
	elif stageSelecting == 8:
		hideStageSprites()
		stage_8_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_8
		Global.waveNum = 5
		Global.current_stage = "Conic Cove"
		Global.stage_index = 8
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
		resetStarParticles()
		if Global.Stage8StarsAchieved >= 1:
			star_particle_2.visible = true
		if Global.Stage8StarsAchieved >= 2:
			star_particle_3.visible = true
		if Global.Stage8StarsAchieved >= 3:
			star_particle_4.visible = true
		if Global.Stage8StarsAchieved >= 4:
			star_particle_5.visible = true
		if Global.Stage8StarsAchieved >= 5:
			star_particle_6.visible = true
	elif stageSelecting == 9:
		hideStageSprites()
		stage_9_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_9
		Global.waveNum = 5
		Global.current_stage = "Steamy Stream"
		Global.stage_index = 9
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
		resetStarParticles()
		if Global.Stage9StarsAchieved >= 1:
			star_particle_2.visible = true
		if Global.Stage9StarsAchieved >= 2:
			star_particle_3.visible = true
		if Global.Stage9StarsAchieved >= 3:
			star_particle_4.visible = true
		if Global.Stage9StarsAchieved >= 4:
			star_particle_5.visible = true
		if Global.Stage9StarsAchieved >= 5:
			star_particle_6.visible = true
	elif stageSelecting == 10:
		hideStageSprites()
		stage_10_sprites.visible = true
		stage_select_back.texture = STAGE_SELECT_BACK_S_10
		Global.waveNum = 7
		Global.current_stage = "Massive Marsh"
		Global.stage_index = 10
		stage_words.text = "Stage " + str(Global.stage_index) + ": " + Global.current_stage
		establish_arrows()
		resetStarParticles()
		if Global.Stage10StarsAchieved >= 1:
			star_particle_1.visible = true
		if Global.Stage10StarsAchieved >= 2:
			star_particle_2.visible = true
		if Global.Stage10StarsAchieved >= 3:
			star_particle_3.visible = true
		if Global.Stage10StarsAchieved >= 4:
			star_particle_4.visible = true
		if Global.Stage10StarsAchieved >= 5:
			star_particle_5.visible = true
		if Global.Stage10StarsAchieved >= 6:
			star_particle_6.visible = true
		if Global.Stage10StarsAchieved >= 7:
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


func hideStageSprites():
	stage_1_sprites.visible = false
	stage_2_sprites.visible = false
	stage_3_sprites.visible = false
	stage_4_sprites.visible = false
	stage_5_sprites.visible = false
	stage_6_sprites.visible = false
	stage_7_sprites.visible = false
	stage_8_sprites.visible = false
	stage_9_sprites.visible = false
	stage_10_sprites.visible = false

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




























