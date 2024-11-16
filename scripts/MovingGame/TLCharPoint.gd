extends Node2D

@onready var tl_ray_cast_2d = $"../TLRayCast2D"
@onready var default_tl_point = $"../DefaultTLPoint"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tl_ray_cast_2d.is_colliding():
		var col_point = tl_ray_cast_2d.get_collision_point()
		
		global_position = col_point
	else:
		position = default_tl_point.position
