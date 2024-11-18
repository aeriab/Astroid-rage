extends CanvasLayer

@onready var lotl_kills = $LotlKills

func _ready():
	lotl_kills.text = "You've killed " + str(Global.lotlKills) + " axolotls!"
	lotl_kills.material.set_shader_parameter("slow_by_mult",maxf(1.0/13.0,1.0/(Global.lotlKills * 0.02 + 1.0)))
	#print("slow mult: " + str(maxf(1.0/13.0,1.0/(Global.lotlKills * 0.02 + 1.0))))
	lotl_kills.material.set_shader_parameter("vibrant_color",minf(20,10 + (Global.lotlKills * 0.1)))
	#print("color: " + str(minf(20,10 + (Global.lotlKills * 0.1))))

func _on_play_button_pressed():
	Global.resetStats()
	if Global.didTutorial == true:
		get_tree().change_scene_to_file("res://scenes/playable_scenes/stage_select.tscn")
	else:
		Global.current_stage = "Tutorial Tidepool"
		get_tree().change_scene_to_file("res://scenes/playable_scenes/game.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_minigame_select_pressed():
	Global.inPracticeMode = true
	Global.resetStats()
	get_tree().change_scene_to_file("res://scenes/playable_scenes/minigame_select.tscn")

