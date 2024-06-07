extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float

@onready var mutation_part = $mutationPart

var eyelidHeight: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = (starting_rot / 360) * 2 * PI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mutation_part.scaleEyelid(eyelidHeight)
	
	Global.prior_dir = clockwise
	if Input.is_action_just_pressed("switch"):
		clockwise *= -1
		
		if eyelidHeight <= 0.5:
			eyelidHeight += 0.3
		else:
			eyelidHeight = 0.5
	else:
		if eyelidHeight > 0:
			eyelidHeight -= delta * 0.5
	if !pause_rot:
		rotation += (Global.rotationSpeed * clockwise * delta)
