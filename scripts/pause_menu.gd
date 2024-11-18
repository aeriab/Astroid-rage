extends CanvasLayer

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	Global.resetStats()
	visible = false
	Global.gameTimeScale = 1.0

func _on_resume_button_pressed():
	resume()

func resume():
	visible = false
	Global.gameTimeScale = Global.lastTimeScale


func starsAwarding():
	return int(Global.firstWaveProgress > 100) + int(Global.secondWaveProgress > 100) + int(Global.thirdWaveProgress > 100) + int(Global.fourthWaveProgress > 100) + int(Global.fifthWaveProgress > 100) + int(Global.sixthWaveProgress > 100) + int(Global.seventhWaveProgress > 100)


func _on_stage_button_pressed():
	
	if Global.current_stage == "Learner Lagoon" && starsAwarding() > Global.Stage1StarsAchieved:
		Global.Stage1StarsAchieved = starsAwarding()
	elif Global.current_stage == "Perfect Pond" && starsAwarding() > Global.Stage2StarsAchieved:
		Global.Stage2StarsAchieved = starsAwarding()
	elif Global.current_stage == "Giga Geyser" && starsAwarding() > Global.Stage3StarsAchieved:
		Global.Stage3StarsAchieved = starsAwarding()
	elif Global.current_stage == "Swirly Swamp" && starsAwarding() > Global.Stage4StarsAchieved:
		Global.Stage4StarsAchieved = starsAwarding()
	elif Global.stage_index == 5 && starsAwarding() > Global.Stage5StarsAchieved:
		Global.Stage5StarsAchieved = starsAwarding()
	elif Global.stage_index == 6 && starsAwarding() > Global.Stage6StarsAchieved:
		Global.Stage6StarsAchieved = starsAwarding()
	elif Global.stage_index == 7 && starsAwarding() > Global.Stage7StarsAchieved:
		Global.Stage7StarsAchieved = starsAwarding()
	elif Global.stage_index == 8 && starsAwarding() > Global.Stage8StarsAchieved:
		Global.Stage8StarsAchieved = starsAwarding()
	elif Global.stage_index == 9 && starsAwarding() > Global.Stage9StarsAchieved:
		Global.Stage9StarsAchieved = starsAwarding()
	elif Global.stage_index == 10 && starsAwarding() > Global.Stage10StarsAchieved:
		Global.Stage10StarsAchieved = starsAwarding()
	
	if Global.didTutorial:
		Global.resetStats()
		get_tree().change_scene_to_file("res://scenes/playable_scenes/stage_select.tscn")
		Global.gameTimeScale = 1.0
	else:
		Global.resetStats()
		Global.current_stage = "Learner Lagoon"
		Global.stage_index = 1
		get_tree().change_scene_to_file("res://scenes/playable_scenes/intro_video.tscn")
		Global.gameTimeScale = 1.0
