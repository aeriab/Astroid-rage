extends Sprite2D


func _process(_delta):
	material.set_shader_parameter("crash_progress",Global.crashTime)
