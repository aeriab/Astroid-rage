extends RigidBody2D

@onready var goldfish = $Goldfish


var shader_value = material.get_shader_parameter("value")
var damage_chunk = 0.15

func _ready():
	shader_value = 0.0

func addDamage():
	shader_value = shader_value + damage_chunk
	
	shader_value = clamp(shader_value,0.0,1.0)
	
	goldfish.makeRed(shader_value)
	
	if shader_value >= 0.9:
		Global.decreaseEnemyNum()
		call_deferred("queue_free")

func _on_body_entered(body):
	print(str(body))
