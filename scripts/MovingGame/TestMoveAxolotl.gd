extends Area2D

var SPEED = 250.0
var ROT_SPEED = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(str(-rotation + (3 * PI / 2)))
	var heading = (-rotation)
	
	if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W):
		position.y += SPEED * delta * cos(heading)
		position.x += SPEED * delta * sin(heading)
	
	if Input.is_key_pressed(KEY_E):
		rotate(delta * ROT_SPEED)
	elif Input.is_key_pressed(KEY_Q):
		rotate(delta * ROT_SPEED * (-1))
