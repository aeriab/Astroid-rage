extends Node

const GREEN_SPOT = preload("res://scenes/boogers/exploding_booger_area.tscn")
const SHOT_PARTICLES = preload("res://scenes/shoot_particles.tscn")
@onready var mark_eye_1 = $"../Player/mutationPart/MarkEye1"
@onready var mark_eye_2 = $"../Player/mutationPart/MarkEye2"

@onready var mutation_part = $"../Player/mutationPart"


var theta: float = 0.0

var glowEyeSpeed: float = 0.2

func _ready():
	Global.explodeBoogers = true

func _process(delta):
	
	if !Global.explodeBoogers:
		if mark_eye_1.scale.x < 2.5:
			mark_eye_1.scale.x += delta * Global.gameTimeScale * glowEyeSpeed
			mark_eye_2.scale.x += delta * Global.gameTimeScale * glowEyeSpeed
			mark_eye_1.scale.y += delta * Global.gameTimeScale * glowEyeSpeed
			mark_eye_2.scale.y += delta * Global.gameTimeScale * glowEyeSpeed
	else:
		if mark_eye_1.scale.x > 0.504:
			mark_eye_1.scale.x -= delta * Global.gameTimeScale * 8.0 * glowEyeSpeed
			mark_eye_1.scale.y -= delta * Global.gameTimeScale * 8.0 * glowEyeSpeed
		else:
			mark_eye_1.scale.x = 0.504
			mark_eye_1.scale.y = 0.504
		
		if mark_eye_2.scale.x > 0.504:
			mark_eye_2.scale.x -= delta * Global.gameTimeScale * 8.0 * glowEyeSpeed
			mark_eye_2.scale.y -= delta * Global.gameTimeScale * 8.0 * glowEyeSpeed
		else:
			mark_eye_2.scale.x = 0.504
			mark_eye_2.scale.y = 0.504
	
	if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		Global.explodeBoogers = false
		var greenspot = GREEN_SPOT.instantiate()
		var shotparticles = SHOT_PARTICLES.instantiate()
		
		get_parent().add_child.call_deferred(greenspot)
		get_parent().add_child.call_deferred(shotparticles)
		var x: float = mutation_part.snoutPositionX()
		var y: float = mutation_part.snoutPositionY()
		
		var snout_length = sqrt((x * x) + (y * y))
		
		if y < 0:
			theta = acos(x / snout_length)
		else:
			theta = 2 * PI -  acos(x / snout_length)
		
		greenspot.set_motion(x,y,theta,1)
		shotparticles.start_emit(x,y,theta)
	
	if Input.is_action_just_released("switch") && Global.gameTimeScale > 0.1:
		Global.explodeBoogers = true
