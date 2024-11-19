extends Node2D

@onready var tl_target_point = $"../../Axolotl/TRTargetPoint"
@onready var axolotl = $"../../Axolotl"
var maxDistance: float = 600.0

var KEEPUP_SPEED = 3000.0

var actual_target

# Called when the node enters the scene tree for the first time.
func _ready():
	actual_target = position
var alreadyFree: bool = false
func stopTrying():
	alreadyFree = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !alreadyFree:
		var targPos = tl_target_point.global_position
		var distToTarget = sqrt((actual_target.x - targPos.x) * (actual_target.x - targPos.x) + (actual_target.y - targPos.y) * (actual_target.y - targPos.y))
		if distToTarget > maxDistance:
			actual_target = targPos
		
		if global_position.x < actual_target.x - 10.0:
			global_position.x += KEEPUP_SPEED * delta
		if global_position.x > actual_target.x + 10.0:
			global_position.x -= KEEPUP_SPEED * delta
		
		if global_position.y < actual_target.y - 10.0:
			global_position.y += KEEPUP_SPEED * delta
		if global_position.y > actual_target.y + 10.0:
			global_position.y -= KEEPUP_SPEED * delta
	
