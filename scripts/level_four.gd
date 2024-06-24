extends Node2D
@onready var pause_menu = $PauseMenu

func _ready():
	Global.gameTimeScale = 1.0
	Global.resetStats()
	
	Global.curHighscore = Global.autoHighscore
	Global.curS1 = Global.autoS1
	Global.curS2 = Global.autoS2
	Global.curS3 = Global.autoS3
	Global.curS4 = Global.autoS4
	Global.curS5 = Global.autoS5
	Global.curS6 = Global.autoS6
	Global.curS7 = Global.autoS7
	
	Global.curStage = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Global.gameTimeScale = 0.0
