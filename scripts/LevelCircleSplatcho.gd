extends Sprite2D
@onready var level_label = $"../LevelLabel"

func _physics_process(_delta):
	material.set_shader_parameter("level_progress",Global.xpAmount)
	level_label.text = "LEVEL\n" + str(Global.level)

#func _on_level_circle_xp_going_up():
	#print("made here")
	
