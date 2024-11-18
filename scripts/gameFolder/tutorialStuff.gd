extends Node2D

@onready var deploy_drone_icon = $tutCanvasLayer/MaterialParent/DeployDroneIcon
@onready var fire_icon_1_ = $"tutCanvasLayer/MaterialParent/FireIcon(1)"
@onready var navigate_drone_icon = $tutCanvasLayer/MaterialParent/NavigateDroneIcon

@onready var fire_timer = $"tutCanvasLayer/MaterialParent/FireIcon(1)/FireTimer"
@onready var nav_timer = $tutCanvasLayer/MaterialParent/NavigateDroneIcon/NavTimer
@onready var next_instruct_timer = $tutCanvasLayer/MaterialParent/NextInstructTimer

var curInstruct: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up") && Global.gameTimeScale > 0.1:
		deploy_drone_icon.visible = false
		curInstruct = 3
		next_instruct_timer.start()

@onready var material_parent = $tutCanvasLayer/MaterialParent

func _on_fire_timer_timeout():
	fire_icon_1_.visible = false
	curInstruct = 2
	next_instruct_timer.start()


func _on_nav_timer_timeout():
	navigate_drone_icon.visible = false
	curInstruct = 4


func _on_next_instruct_timer_timeout():
	material_parent.timeKeep = 0
	if curInstruct == 2:
		deploy_drone_icon.visible = true
	elif curInstruct == 3:
		navigate_drone_icon.visible = true
		nav_timer.start()
