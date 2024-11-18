extends CanvasLayer

func _on_play_button_pressed():
	Global.resetStats()
	if Global.didTutorial == true:
		get_tree().change_scene_to_file("res://scenes/playable_scenes/stage_select.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/playable_scenes/game.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_minigame_select_pressed():
	Global.inPracticeMode = true
	Global.resetStats()
	get_tree().change_scene_to_file("res://scenes/playable_scenes/minigame_select.tscn")

