extends Node2D

var x = 5000
var y = 5000

var innerBoundX = 500
var innerBoundY = 500
var outerBoundX = 3900
var outerBoundY = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
	if randi_range(0,1) == 1:
		y = -y
	rotation = randf_range(0,2*PI)
	
	position = Vector2(x,y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
