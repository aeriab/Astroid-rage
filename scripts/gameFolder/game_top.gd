extends Node2D
@onready var pause_menu = $PauseMenu
@onready var camera_2d = $Crasher/Camera2D
@onready var crasher = $Crasher
@onready var mutation_part = $Player/mutationPart

const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")

var crashTransPlace: float = 0.0
var transScale: float = 1.0
var firstCrash: bool = true
var x: float = 0
var y: float = 0
var theta: float

func _ready():
	Global.gameTimeScale = 1.0
	Global.resetStats()
	
	Global.curHighscore = Global.gameHighscore
	
	Global.curStage = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.startCrasher:
		if crashTransPlace < 1.0:
			crashTransPlace += delta * transScale
			camera_2d.zoom.x = (0.3 * crashTransPlace) + 0.2
			camera_2d.zoom.y = (0.3 * crashTransPlace) + 0.2
			Global.gameTimeScale = 1.0 - (crashTransPlace * 0.85)
			
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
			
			crasher.rotation = theta - PI
			x += cos(theta) * delta * Global.gameTimeScale * 1000
			y -= sin(theta) * delta * Global.gameTimeScale * 1000
			crasher.position.x = x
			crasher.position.y = y
			
		else:
			firstCrash = true
			crashTransPlace = 1.0
			Global.startCrasher = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Global.gameTimeScale = 0.0
