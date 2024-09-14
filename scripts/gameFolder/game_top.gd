extends Node2D
@onready var pause_menu = $PauseMenu
@onready var camera_2d = $Camera2D

@onready var drone

@onready var mutation_part
@onready var tank = $Tank
@onready var mark = $Mark
@onready var ball = $Ball
@onready var lazy = $Lazy


const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

var crashTransPlace: float = 0.0
var transScale: float = 1.0
var firstCrash: bool = true
var x: float = 0
var y: float = 0
var theta: float
var impact_length: float = 0.0
var first_impact: bool = true
@onready var crasher_area_2d = $CrasherArea2D
@onready var spray = $SprayNode2D
@onready var fling = $FlingNode2D


func _ready():
	
	if Global.curDroneNumber != 1:
		crasher_area_2d.queue_free()
	if Global.curDroneNumber != 2:
		spray.queue_free()
	if Global.curDroneNumber != 3:
		fling.queue_free()
	
	if Global.curDroneNumber == 1:
		drone = $CrasherArea2D
	elif Global.curDroneNumber == 2:
		drone = $SprayNode2D/Spray
	elif Global.curDroneNumber == 3:
		drone = $FlingNode2D/Fling

	
	
	
	
	if Global.curBaseNumber != 1:
		tank.queue_free()
	if Global.curBaseNumber != 2:
		ball.queue_free()
	if Global.curBaseNumber != 3:
		mark.queue_free()
	if Global.curBaseNumber != 4:
		lazy.queue_free()
	
	if Global.curBaseNumber == 1:
		mutation_part = $Tank/Player/mutationPart
	elif Global.curBaseNumber == 2:
		mutation_part = $Ball/Player/mutationPart
	elif Global.curBaseNumber == 3:
		mutation_part = $Mark/Player/mutationPart
	elif Global.curBaseNumber == 4:
		mutation_part = $Lazy/Player/mutationPart
	
	
	Global.bulletSize = (Global.num_base_stars4 + 1.2) * 2.0
	Global.rotationSpeed = (Global.num_base_stars5 * 0.35) + 1.5
	Global.damage = (2.5 * Global.num_base_stars3) + 2.0
	
	Global.gameTimeScale = 1.0
	Global.resetStats()
	Global.curHighscore = Global.gameHighscore
	Global.curStage = -1
	
	Global.startCrasher = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global.startCrasher and !Global.crashStarted:
		firstCrash = true
		if crashTransPlace > 0.0:
			crashTransPlace -= delta * transScale
			camera_2d.zoom.x = (0.3 * crashTransPlace) + 0.2
			camera_2d.zoom.y = (0.3 * crashTransPlace) + 0.2
			
			if first_impact:
				Global.softCam = true
				drone.position.x = 0
				drone.position.y = 0
				first_impact = false
			
		else:
			Global.impactSequence = false
			if !Global.gameOver && !pause_menu.visible && Global.camXSet && Global.camYSet:
				Global.gameTimeScale = 1.0
				Global.softCam = false
			crashTransPlace = 0.0
			camera_2d.zoom.x = 0.2
			camera_2d.zoom.y = 0.2
			drone.position.x = 0
			drone.position.y = 0
	
	if Global.startCrasher:
		Global.softCam = true
		if crashTransPlace < 1.0:
			Global.lastTimeScale = 0.15
			crashTransPlace += delta * transScale
			camera_2d.zoom.x = (0.3 * crashTransPlace) + 0.2
			camera_2d.zoom.y = (0.3 * crashTransPlace) + 0.2
			mutation_part.scaleNose(3.5 * sqrt(1 - ((1.8*crashTransPlace) -0.9) * ((1.8*crashTransPlace) -0.9)) - 0.526)
			Global.gameTimeScale = 0
			
			if firstCrash:
			
				var shotparticles = SHOT_PARTICLES.instantiate()
				get_parent().add_child.call_deferred(shotparticles)
				x = mutation_part.snoutPositionX()
				y = mutation_part.snoutPositionY()
			
				var snout_length = sqrt((x * x) + (y * y))
			
				if y < 0:
					theta = acos(x / snout_length)
				else:
					theta = 2 * PI -  acos(x / snout_length)
				
				if Global.curBaseNumber == 2:
					theta = theta - PI
				
				shotparticles.start_emit(x,y,theta)
				firstCrash = false
				
				x = 0
				y = 0
			
			drone.rotation = PI/2 - theta
			x += cos(theta) * delta * 1000
			y -= sin(theta) * delta * 1000
			drone.position.x = x
			drone.position.y = y
			
		else:
			if !Global.gameOver && !pause_menu.visible && Global.camXSet && Global.camYSet:
				Global.gameTimeScale = 0.15
				Global.softCam = false
				firstCrash = true
				crashTransPlace = 1.0
				Global.startCrasher = false
				Global.crashStarted = true
				first_impact = true
	
	if Input.is_action_just_pressed("ui_cancel") && !pause_menu.visible && !Global.gameOver:
		pause_menu.visible = true
		Global.lastTimeScale = Global.gameTimeScale
		Global.gameTimeScale = 0.0

func origVars():
	crashTransPlace = 0.0
	transScale = 1.0
	firstCrash = true
	x = 0
	y = 0
	theta = 0
	impact_length = 0.0
	first_impact = true
	Global.startCrasher = false
	Global.crashStarted = false
	Global.impactSequence = false
	Global.softCam = false
	Global.crashTime = 6.3
