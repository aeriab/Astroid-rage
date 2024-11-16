extends Area2D

var SPEED = 250.0
var ROT_SPEED = 2.0

@onready var tank = $"../Tank"
@onready var ball = $"../Ball"
@onready var mark = $"../Mark"
@onready var lazy = $"../Lazy"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.curBaseNumber == 1:
		tank.position = position
	if Global.curBaseNumber == 2:
		ball.position = position
	if Global.curBaseNumber == 3:
		mark.position = position
	if Global.curBaseNumber == 4:
		lazy.position = position
	
	var heading = (-rotation)
	
	if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W):
		position.y += SPEED * delta * cos(heading)
		position.x += SPEED * delta * sin(heading)
	
	if Input.is_key_pressed(KEY_E):
		rotate(delta * ROT_SPEED)
	elif Input.is_key_pressed(KEY_Q):
		rotate(delta * ROT_SPEED * (-1))
	
	
	
