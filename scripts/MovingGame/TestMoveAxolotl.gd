extends Area2D

var SPEED = 250.0
var ROT_SPEED = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W):
		position.y -= SPEED * delta
	elif Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S):
		position.y += SPEED * delta
	
	if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D):
		position.x += SPEED * delta
	
	if Input.is_key_pressed(KEY_E):
		rotate(delta * ROT_SPEED)
	elif Input.is_key_pressed(KEY_Q):
		rotate(delta * ROT_SPEED * (-1))
