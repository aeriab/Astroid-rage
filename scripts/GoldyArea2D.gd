extends Area2D

@onready var goldfish = $Goldfish

var shader_value = material.get_shader_parameter("value")
var damage_chunk = Global.damage * 0.05

var x = position.x
var y = position.y
var hypotenuse
var theta

const SPEED = 200

var innerBoundX = 1000
var innerBoundY = 1000
var outerBoundX = 5000
var outerBoundY = 5000

var targetX = 0
var targetY = 0

func _ready():
	randomize()
	shader_value = 0.0
	
	x = randf_range(innerBoundX,outerBoundX)
	if randi_range(0,1) == 1:
		x = -x
	
	y = randf_range(innerBoundY,outerBoundY)
	if randi_range(0,1) == 1:
		y = -y
	
	targetX = randi_range(-2000,2000)
	targetY = randi_range(-1800,-1800)
	
	hypotenuse = sqrt(((x-targetX) * (x-targetX)) + ((y - targetY) * (y-targetX)))
	
	if y < 0:
		theta = acos((x-targetX) / hypotenuse)
	else:
		theta = 2 * PI -  acos((x-targetX) / hypotenuse)
	
	monitoring = true

func _physics_process(delta):
	x -= cos(theta) * SPEED * delta
	y -= -sin(theta) * SPEED * delta
	
	position = Vector2(x,y)

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
