extends Node2D

var timeKeep: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeKeep += delta
	material.set_shader_parameter("opacity_value",0.3 * (-cos(timeKeep * 2) + 1))
