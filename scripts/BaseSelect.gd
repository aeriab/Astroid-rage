extends Label

@onready var right_base_arrow = $RightBaseArrow
@onready var left_base_arrow = $LeftBaseArrow
@onready var tank = $"../BaseIcons/Tank"
@onready var lazy = $"../BaseIcons/Lazy"
@onready var mark = $"../BaseIcons/Mark"
@onready var ball = $"../BaseIcons/Ball"

func _ready():
	updateBaseName()
	text = Global.currentBase + "         "
	if Global.currentBase == "Tank":
		right_base_arrow.visible = true
		left_base_arrow.visible = false
	elif Global.currentBase == "Lazy":
		right_base_arrow.visible = false
		left_base_arrow.visible = true
	else:
		right_base_arrow.visible = true
		left_base_arrow.visible = true


func _on_right_base_arrow_pressed():
	if Global.currentBase != "Lazy":
		Global.curBaseNumber += 1
	updateBaseName()


func _on_left_base_arrow_pressed():
	if Global.currentBase != "Tank":
		Global.curBaseNumber -= 1
	updateBaseName()

func tankVisible():
	tank.visible = true
	ball.visible = false
	mark.visible = false
	lazy.visible = false

func ballVisible():
	tank.visible = false
	ball.visible = true
	mark.visible = false
	lazy.visible = false

func markVisible():
	tank.visible = false
	ball.visible = false
	mark.visible = true
	lazy.visible = false

func lazyVisible():
	tank.visible = false
	ball.visible = false
	mark.visible = false
	lazy.visible = true

func updateBaseName():
	if Global.curBaseNumber == 1:
		Global.currentBase = "Tank"
		tankVisible()
	elif Global.curBaseNumber == 2:
		Global.currentBase = "Ball"
		ballVisible()
	elif Global.curBaseNumber == 3:
		Global.currentBase = "Mark"
		markVisible()
	elif Global.curBaseNumber == 4:
		Global.currentBase = "Lazy"
		lazyVisible()
	
	text = Global.currentBase + "         "
	if Global.currentBase == "Tank":
		right_base_arrow.visible = true
		left_base_arrow.visible = false
	elif Global.currentBase == "Lazy":
		right_base_arrow.visible = false
		left_base_arrow.visible = true
	else:
		right_base_arrow.visible = true
		left_base_arrow.visible = true



