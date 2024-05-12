extends Node2D

var x = position.x
var y = position.y
var hypotenuse
var theta

const SPEED = 200

func _ready():
	hypotenuse = sqrt((x * x) + (y * y))
	
	#print(hypotenuse)
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)

func _physics_process(delta):
	x -= cos(theta) * SPEED * delta
	y -= -sin(theta) * SPEED * delta
	
	position = Vector2(x,y)
