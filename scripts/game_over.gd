extends CanvasLayer


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	Global.resetStats()
	visible = false
	Engine.time_scale = 1.0

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
