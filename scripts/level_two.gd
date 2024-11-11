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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Global.lastTimeScale = Global.gameTimeScale
		Global.gameTimeScale = 0.0
		
