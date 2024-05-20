extends CanvasLayer


func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
