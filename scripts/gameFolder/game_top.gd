extends Node2D
@onready var pause_menu = $PauseMenu
@onready var camera_2d = $Camera2D

@onready var crasher = $CrasherArea2D

@onready var mutation_part = $Player/mutationPart

const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

var crashTransPlace: float = 0.0
var transScale: float = 1.0
var firstCrash: bool = true
var x: float = 0
var y: float = 0
var theta: float
var impact_length: float = 0.0
var first_impact: bool = true

func _ready():
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
				crasher.position.x = 0
				crasher.position.y = 0
				first_impact = false
			
		else:
			Global.impactSequence = false
			if !Global.gameOver && !pause_menu.visible && Global.camXSet && Global.camYSet:
				Global.gameTimeScale = 1.0
				Global.softCam = false
			crashTransPlace = 0.0
			camera_2d.zoom.x = 0.2
			camera_2d.zoom.y = 0.2
			crasher.position.x = 0
			crasher.position.y = 0
	
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
				
				shotparticles.start_emit(x,y,theta)
				firstCrash = false
				
				x = 0
				y = 0
			
			crasher.rotation = PI/2 - theta
			x += cos(theta) * delta * 1000
			y -= sin(theta) * delta * 1000
			crasher.position.x = x
			crasher.position.y = y
			
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
