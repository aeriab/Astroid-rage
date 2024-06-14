extends Node2D
@onready var pause_menu = $PauseMenu

func _ready():
	Global.gameTimeScale = 1.0
	Global.resetStats()
	
	Global.curHighscore = Global.highscore
	Global.curS1 = Global.tarPracS1
	Global.curS2 = Global.tarPracS2
	Global.curS3 = Global.tarPracS3
	Global.curS4 = Global.tarPracS4
	Global.curS5 = Global.tarPracS5
	Global.curS6 = Global.tarPracS6
	Global.curS7 = Global.tarPracS7
	
	Global.curStage = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Global.gameTimeScale = 0.0
	
	#if Input.is_action_just_pressed("ui_cancel") && pause_menu.visible:
		#pause_menu.resume()
