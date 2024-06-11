extends CanvasLayer


func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	Global.resetStats()
	visible = false
	Engine.time_scale = 1.0

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	Engine.time_scale = 1.0


func _on_resume_button_pressed():
	visible = false
	Engine.time_scale = 1.0
