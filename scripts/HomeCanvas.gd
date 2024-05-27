extends CanvasLayer


func _on_endless_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_store_page_button_pressed():
	get_tree().change_scene_to_file("res://scenes/store_page.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
