extends Label

@onready var right_drone_arrow = $RightDroneArrow
@onready var left_drone_arrow = $LeftDroneArrow
@onready var crash = $"../DroneIcons/Crash"
@onready var spray = $"../DroneIcons/Spray"
@onready var fling = $"../DroneIcons/Fling"
@onready var gob = $"../DroneIcons/Gob"

func _ready():
	text = Global.currentDrone + "         "
	if Global.currentDrone == "Crash":
		right_drone_arrow.visible = true
		left_drone_arrow.visible = false
	elif Global.currentDrone == "Gob":
		right_drone_arrow.visible = false
		left_drone_arrow.visible = true
	else:
		right_drone_arrow.visible = true
		left_drone_arrow.visible = true


func _on_right_drone_arrow_pressed():
	if Global.currentDrone != "Gob":
		Global.curDroneNumber += 1
	updateDroneName()


func _on_left_drone_arrow_pressed():
	if Global.currentDrone != "Crash":
		Global.curDroneNumber -= 1
	updateDroneName()

func crashVisible():
	crash.visible = true
	spray.visible = false
	fling.visible = false
	gob.visible = false

func sprayVisible():
	crash.visible = false
	spray.visible = true
	fling.visible = false
	gob.visible = false

func flingVisible():
	crash.visible = false
	spray.visible = false
	fling.visible = true
	gob.visible = false

func gobVisible():
	crash.visible = false
	spray.visible = false
	fling.visible = false
	gob.visible = true


func updateDroneName():
	if Global.curDroneNumber == 1:
		Global.currentDrone = "Crash"
		crashVisible()
	elif Global.curDroneNumber == 2:
		Global.currentDrone = "Spray"
		sprayVisible()
	elif Global.curDroneNumber == 3:
		Global.currentDrone = "Fling"
		flingVisible()
	elif Global.curDroneNumber == 4:
		Global.currentDrone = "Gob"
		gobVisible()
	
	text = Global.currentDrone + "         "
	if Global.currentDrone == "Crash":
		right_drone_arrow.visible = true
		left_drone_arrow.visible = false
	elif Global.currentDrone == "Gob":
		right_drone_arrow.visible = false
		left_drone_arrow.visible = true
	else:
		right_drone_arrow.visible = true
		left_drone_arrow.visible = true




