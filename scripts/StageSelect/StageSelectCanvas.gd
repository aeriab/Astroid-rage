extends CanvasLayer

var stageSelecting: int = 1
var MAX_STAGE: int = 4
@onready var stage_words = $StageWords
@onready var left_stage_arrow = $LeftStageArrow
@onready var right_stage_arrow = $RightStageArrow
@onready var upgrades_left_label = $UpgradesLeftLabel

func _ready():
	upgrades_left_label.text = "UPGRADES\nLEFT: " + str(Global.unspentPoints)

func _process(_delta):
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
