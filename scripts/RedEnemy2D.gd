extends Area2D

var shader_value = material.get_shader_parameter("value")
var shader_alpha = material.get_shader_parameter("alpha")
var damage_chunk = Global.damage * 0.05

var x = 5000
var y = 5000
var hypotenuse
var theta

const SPEED = 200
const FADE_SPEED = 0.5

var innerBoundX = 3000
var innerBoundY = 3000
var outerBoundX = 5000
var outerBoundY = 5000

var time_ellapsed = 0

var flipSprite: int = 1

var enemyIndex = 0


func spawn():
	Global.enemyNum += 1
	enemyIndex = Global.enemyNum
	
	shader_alpha = 0.0
	
	material.set_shader_parameter("alpha_value",shader_alpha)
	
	randomize()
	shader_value = 0.0
	
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	hypotenuse = sqrt((x * x) + (y * y))
	
	if y < 0:
		theta = acos(x / hypotenuse)
	else:
		theta = 2 * PI -  acos(x / hypotenuse)
	
	rotation = -theta + PI

func _physics_process(delta):
	
	x -= cos(theta) * SPEED * delta
	y -= -sin(theta) * SPEED * delta
	
	scale.y = ((sin(time_ellapsed) * 0.2) + 1.0) * flipSprite
	
	position = Vector2(x,y)
	time_ellapsed += delta * 5
	if shader_alpha != 1.0:
		shader_alpha += FADE_SPEED * delta
		shader_alpha = clamp(shader_alpha,0.0,1.0)
		material.set_shader_parameter("alpha_value",shader_alpha)
	

func addDamage():
	shader_value = shader_value + damage_chunk
	
	shader_value = clamp(shader_value,0.0,1.0)
	
	material.set_shader_parameter("damage_value",shader_value)
	
	if shader_value >= 0.9:
		Global.decreaseEnemyNum()
		call_deferred("queue_free")

func _on_area_entered(area):
	if area.name.substr(0,1) == "@" || area.name == "BoogerArea":
		area.setFreeLater()
		addDamage()
	
	if area.name.substr(0,4) == "Bird":
		Global.decreaseHealth(1.0 - shader_value)
		call_deferred("queue_free")
