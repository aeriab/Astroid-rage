extends Node2D
@onready var pause_menu = $PauseMenu

func _ready():
	Global.gameTimeScale = 1.0
	Global.resetStats()
	
	Global.curHighscore = Global.ricoHighscore
	Global.curS1 = Global.ricoS1
	Global.curS2 = Global.ricoS2
	Global.curS3 = Global.ricoS3
	Global.curS4 = Global.ricoS4
	Global.curS5 = Global.ricoS5
	Global.curS6 = Global.ricoS6
	Global.curS7 = Global.ricoS7
	
	Global.curStage = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Global.lastTimeScale = Global.gameTimeScale
		Global.gameTimeScale = 0.0
