extends Node2D
@onready var pause_menu = $PauseMenu

func _ready():
	Engine.time_scale = 1.0
	Global.resetStats()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Engine.time_scale = 0.0
