extends Area2D

var shader_value = material.get_shader_parameter("value")
var damage_chunk = Global.damage * 0.05

var x = position.x
var y = position.y
var hypotenuse
var theta

const SPEED = 200

var innerBoundX = 1000
var innerBoundY = 1000
var outerBoundX = 3000
var outerBoundY = 3000

var time_ellapsed = 0

var flipSprite: int = 1

func _ready():
	randomize()
	shader_value = 0.0
	
	x = randf_range(innerBoundX,outerBoundX)
	if randi_range(0,1) == 1:
		x = -x
	else:
		flipSprite = -1
		#pass
	
	y = randf_range(innerBoundY,outerBoundY)
	if randi_range(0,1) == 1:
		y = -y
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)
	
	rotation = -theta + PI
	#if x <= 0:
		#rotation = (theta - PI)
	
	monitoring = true


func _physics_process(delta):
	x -= cos(theta) * SPEED * delta
	y -= -sin(theta) * SPEED * delta
	
	scale.y = ((sin(time_ellapsed) * 0.2) + 1.0) * flipSprite
	
	position = Vector2(x,y)
	time_ellapsed += delta * 5

func addDamage():
	shader_value = shader_value + damage_chunk
	
	shader_value = clamp(shader_value,0.0,1.0)
	
	material.set_shader_parameter("damage_value",shader_value)
	
	if shader_value >= 0.9:
		Global.decreaseEnemyNum()
		call_deferred("queue_free")

func _on_area_entered(area):
	if area.name.substr(0,1) == "@" || area.name == "BoogerArea":
		area.free()
		addDamage()
