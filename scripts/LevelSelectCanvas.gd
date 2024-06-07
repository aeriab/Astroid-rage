extends CanvasLayer


func _on_level_one_pressed():
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")


func _on_level_two_pressed():
	get_tree().change_scene_to_file("res://scenes/level_two.tscn")


func _on_level_three_pressed():
	get_tree().change_scene_to_file("res://scenes/level_three.tscn")


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
