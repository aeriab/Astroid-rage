extends Area2D

var x
var y
var theta
var SPEED = 200 * Global.bulletSpeed

var _scale = Vector2(Global.bulletSize / 8.0,Global.bulletSize / 8.0)

func _ready():
	monitoring = true
	
	set_scale(_scale)

func set_motion(x1,y1,theta1):
	x = x1
	y = y1
	theta = theta1

func _physics_process(delta):
	
	x += cos(theta) * SPEED * delta
	y -= sin(theta) * SPEED * delta
	
	position.x = x
	position.y = y

func _on_area_entered(area):
	if area.name == "AreaBulletCollection":
		queue_free()
