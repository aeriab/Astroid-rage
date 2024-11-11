extends Node2D
@onready var pause_menu = $PauseMenu

func _ready():
	Global.gameTimeScale = 1.0
	Global.resetStats()
	
	Global.curHighscore = Global.popHighscore
	Global.curS1 = Global.popS1
	Global.curS2 = Global.popS2
	Global.curS3 = Global.popS3
	Global.curS4 = Global.popS4
	Global.curS5 = Global.popS5
	Global.curS6 = Global.popS6
	Global.curS7 = Global.popS7
	
	Global.curStage = 2
	
	Global.bulletSize = (2 + 1.2) * 2.0
	Global.rotationSpeed = (2 * 0.35) + 1.2
	Global.damage = (2.5 * 50) + 2.0
	
	Global.rotationSpeed = 2.0
	Global.bulletSpeed = 2.0
	
	Global.needBaseStarRevert = true
	Global.temp_base_stars1 = Global.num_base_stars1
	Global.temp_base_stars2 = Global.num_base_stars2
	Global.temp_base_stars3 = Global.num_base_stars3
	Global.temp_base_stars4 = Global.num_base_stars4
	Global.temp_base_stars5 = Global.num_base_stars5
	
	Global.num_base_stars1 = 4
	Global.num_base_stars2 = 2
	Global.num_base_stars3 = 2
	Global.num_base_stars4 = 2
	Global.num_base_stars5 = 2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Global.lastTimeScale = Global.gameTimeScale
		Global.gameTimeScale = 0.0
		
