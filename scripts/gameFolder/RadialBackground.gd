extends Sprite2D
const RADIAL_BACKGROUND_BIG = preload("res://assets/StageBackground/radial background big.png")
const RADIAL_BACKGROUND_S_2 = preload("res://assets/StageBackground/radialBackgroundS2.png")
const RADIAL_BACKGROUND_S_3 = preload("res://assets/StageBackground/radialBackgroundS3.png")
const RADIAL_BACKGROUND_S_4 = preload("res://assets/StageBackground/radialBackgroundS4.png")
const RADIAL_BACKGROUND_S_5 = preload("res://assets/StageBackground/radialBackgroundS5.png")

func _ready():
	if Global.current_stage == "Learner Lagoon" || Global.stage_index == 6:
		texture = RADIAL_BACKGROUND_BIG
	elif Global.current_stage == "Perfect Pond" || Global.stage_index == 8:
		texture = RADIAL_BACKGROUND_S_2
	elif Global.current_stage == "Giga Geyser" || Global.stage_index == 10:
		texture = RADIAL_BACKGROUND_S_3
	elif Global.current_stage == "Swirly Swamp" || Global.stage_index == 7:
		texture = RADIAL_BACKGROUND_S_4
	elif Global.stage_index == 5 || Global.stage_index == 9:
		texture = RADIAL_BACKGROUND_S_5
	
