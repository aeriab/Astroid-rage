extends CanvasLayer

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	Global.resetStats()
	visible = false
	Global.gameTimeScale = 1.0

func _on_home_button_pressed():
	Global.resetStats()
	get_tree().change_scene_to_file("res://scenes/playable_scenes/home_menu.tscn")
	Global.gameTimeScale = 1.0

func _on_resume_button_pressed():
	resume()

func resume():
	visible = false
	Global.gameTimeScale = 1.0
