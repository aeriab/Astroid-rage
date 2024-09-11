extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float

@onready var mutation_part = $mutationPart
@onready var pop_sfx_player = $"../PopSfxPlayer"
@onready var crasher = $"../CrasherArea2D"


@onready var mutation_part_2 = $mutationPart2
@onready var mutation_part_3_1_ = $"mutationPart3(1)"
@onready var mutation_part_3_2_ = $"mutationPart3(2)"
@onready var mutation_part_4_1_ = $"mutationPart4(1)"
@onready var mutation_part_4_2_ = $"mutationPart4(2)"
@onready var mutation_part_5_1_ = $"mutationPart5(1)"
@onready var mutation_part_5_2_ = $"mutationPart5(2)"
@onready var mutation_part_5_3_ = $"mutationPart5(3)"
@onready var mutation_part_5_4_ = $"mutationPart5(4)"
@onready var mutation_part_6_1_ = $"mutationPart6(1)"
@onready var mutation_part_6_5_ = $"mutationPart6(5)"


var eyelidHeight: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = (starting_rot / 360) * 2 * PI
	#mutation_part.scaleNose((0.3 * Global.num_base_stars4) + 0.8)
	
	if Global.num_base_stars2 == 1:
		mutation_part_2.visible = true
	elif Global.num_base_stars2 == 2:
		mutation_part_3_1_.visible = true
		mutation_part_3_2_.visible = true
	elif Global.num_base_stars2 == 3:
		mutation_part_4_1_.visible = true
		mutation_part_4_2_.visible = true
		mutation_part_2.visible = true
	elif Global.num_base_stars2 == 4:
		mutation_part_5_1_.visible = true
		mutation_part_5_2_.visible = true
		mutation_part_5_3_.visible = true
		mutation_part_5_4_.visible = true
	elif Global.num_base_stars2 == 5:
		mutation_part_2.visible = true
		mutation_part_3_1_.visible = true
		mutation_part_3_2_.visible = true
		mutation_part_6_1_.visible = true
		mutation_part_6_5_.visible = true

var lastConsec: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mutation_part.scaleEyelid(eyelidHeight)
	
	if Input.is_action_just_pressed("ui_up") && Global.gameTimeScale > 0.1 && !Global.startCrasher && !Global.impactSequence && Global.canDeployCrasher:
		Global.startCrasher = true
	
	Global.prior_dir = clockwise
	if Input.is_action_just_pressed("switch") && Global.gameTimeScale > 0.1:
		
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
