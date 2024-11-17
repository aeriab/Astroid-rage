extends Node2D

@onready var skeleton_2d = $"../../Skeleton2D"
@onready var tl_target_point = $"../../Axolotl/TLTargetPoint"
var maxDistance: float = 300.0

var KEEPUP_SPEED = 3000.0

var actual_target

# Called when the node enters the scene tree for the first time.
func _ready():
	actual_target = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var targPos = tl_target_point.global_position
	var distToTarget = sqrt((actual_target.x - targPos.x) * (actual_target.x - targPos.x) + (actual_target.y - targPos.y) * (actual_target.y - targPos.y))
	if distToTarget > maxDistance:
		actual_target = targPos
	
	if position.x < actual_target.x - 10.0:
		position.x += KEEPUP_SPEED * delta
	if position.x > actual_target.x + 10.0:
		position.x -= KEEPUP_SPEED * delta
	
	if position.y < actual_target.y - 10.0:
		position.y += KEEPUP_SPEED * delta
	if position.y > actual_target.y + 10.0:
		position.y -= KEEPUP_SPEED * delta
	
