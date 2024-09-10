extends Label

@onready var right_base_arrow = $RightBaseArrow
@onready var left_base_arrow = $LeftBaseArrow

func _ready():
	text = Global.currentBase
	if Global.currentBase == "Tank":
		right_base_arrow.visible = true
		left_base_arrow.visible = false
	elif Global.currentBase == "Spike":
		right_base_arrow.visible = false
		left_base_arrow.visible = true
	else:
		right_base_arrow.visible = true
		left_base_arrow.visible = true


func _on_right_base_arrow_pressed():
	if Global.currentBase != "Spike":
		Global.curBaseNumber += 1
	updateBaseName()


func _on_left_base_arrow_pressed():
	if Global.currentBase != "Tank":
		Global.curBaseNumber -= 1
	updateBaseName()

func updateBaseName():
	if Global.curBaseNumber == 1:
		Global.currentBase = "Tank"
	elif Global.curBaseNumber == 2:
		Global.currentBase = "Goopy"
	elif Global.curBaseNumber == 3:
		Global.currentBase = "Exec"
	elif Global.curBaseNumber == 4:
		Global.currentBase = "Spike"
	
	text = Global.currentBase
	if Global.currentBase == "Tank":
		right_base_arrow.visible = true
		left_base_arrow.visible = false
	elif Global.currentBase == "Spike":
		right_base_arrow.visible = false
		left_base_arrow.visible = true
	else:
		right_base_arrow.visible = true
		left_base_arrow.visible = true



