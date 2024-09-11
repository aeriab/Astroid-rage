extends Sprite2D
const RADIAL_BACKGROUND_BIG = preload("res://assets/StageBackground/radial background big.png")
const RADIAL_BACKGROUND_S_2 = preload("res://assets/StageBackground/radialBackgroundS2.png")
const RADIAL_BACKGROUND_S_3 = preload("res://assets/StageBackground/radialBackgroundS3.png")
const RADIAL_BACKGROUND_S_4 = preload("res://assets/StageBackground/radialBackgroundS4.png")

func _ready():
	if Global.current_stage == "Learner Lagoon":
		texture = RADIAL_BACKGROUND_BIG
	elif Global.current_stage == "Perfect Pond":
		texture = RADIAL_BACKGROUND_S_2
	elif Global.current_stage == "Giga Geyser":
		texture = RADIAL_BACKGROUND_S_3
	elif Global.current_stage == "Swirly Swamp":
		texture = RADIAL_BACKGROUND_S_4
	
