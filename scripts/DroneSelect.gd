extends Label

@onready var right_drone_arrow = $RightDroneArrow
@onready var left_drone_arrow = $LeftDroneArrow

func _ready():
	text = Global.currentDrone
	if Global.currentDrone == "Crasher":
		right_drone_arrow.visible = true
		left_drone_arrow.visible = false
	elif Global.currentDrone == "Spade":
		right_drone_arrow.visible = false
		left_drone_arrow.visible = true
	else:
		right_drone_arrow.visible = true
		left_drone_arrow.visible = true


func _on_right_drone_arrow_pressed():
	if Global.currentDrone != "Spade":
		Global.curDroneNumber += 1
	updateDroneName()


func _on_left_drone_arrow_pressed():
	if Global.currentDrone != "Crasher":
		Global.curDroneNumber -= 1
	updateDroneName()


func updateDroneName():
	if Global.curDroneNumber == 1:
		Global.currentDrone = "Crasher"
	elif Global.curDroneNumber == 2:
		Global.currentDrone = "Goldy"
	elif Global.curDroneNumber == 3:
		Global.currentDrone = "Exam"
	elif Global.curDroneNumber == 4:
		Global.currentDrone = "Spade"
	
	text = Global.currentDrone
	if Global.currentDrone == "Crasher":
		right_drone_arrow.visible = true
		left_drone_arrow.visible = false
	elif Global.currentDrone == "Spade":
		right_drone_arrow.visible = false
		left_drone_arrow.visible = true
	else:
		right_drone_arrow.visible = true
		left_drone_arrow.visible = true




