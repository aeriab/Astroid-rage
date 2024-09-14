extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float

@onready var mutation_part = $mutationPart
@onready var pop_sfx_player = $"../../PopSfxPlayer"
@onready var crasher = $"../../CrasherArea2D"

var eyelidHeight: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = (starting_rot / 360) * 2 * PI

var lastConsec: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_up") && Global.gameTimeScale > 0.1 && !Global.startCrasher && !Global.impactSequence && Global.canDeployCrasher && !Global.crashStarted:
		Global.startCrasher = true
	
	
	if Global.consecBulls != lastConsec:
		mutation_part.setFire(Global.consecBulls)
		lastConsec = Global.consecBulls
	
	Global.prior_dir = clockwise
	if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		pop_sfx_player.volume_db = AudioPreload.effectsVolDB
		pop_sfx_player.pitch_scale = randf_range(0.40,1.1)
		var k = randi_range(0,2)
		if k == 0:
			pop_sfx_player.stream = preload("res://assets/popSFX/happy-pop-1-185286.mp3")
		if k == 1:
			pop_sfx_player.stream = preload("res://assets/popSFX/happy-pop-2-185287.mp3")
		else:
			pop_sfx_player.stream = preload("res://assets/popSFX/happy-pop-3-185288.mp3")
		pop_sfx_player.play()
		
		clockwise *= -1
		
		if eyelidHeight <= 0.5:
			eyelidHeight += 0.3
		else:
			eyelidHeight = 0.5
	else:
		if eyelidHeight > 0:
			eyelidHeight -= delta * 0.5 * Global.gameTimeScale
	if !pause_rot:
		rotation += (Global.rotationSpeed * clockwise * delta * Global.gameTimeScale)
