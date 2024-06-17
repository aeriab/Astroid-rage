extends CanvasLayer
@onready var target_highscore = $TargetStars/TargetPractice/TargetHighscore
@onready var pop_highscore = $PopStarContainer/PopStarButton/PopHighscore
@onready var rico_highscore = $RicochetContainer/RicochetButton/RicoHighscore

func _ready():
	target_highscore.text = "HIGHSCORE: " + str(Global.highscore) + " PTS"
	pop_highscore.text = "HIGHSCORE: " + str(Global.popHighscore) + " PTS"
	rico_highscore.text = "HIGHSCORE: " + str(Global.ricoHighscore) + " PTS"

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")


func _on_target_practice_pressed():
	get_tree().change_scene_to_file("res://scenes/target_practice.tscn")


func _on_pop_star_button_pressed():
	get_tree().change_scene_to_file("res://scenes/pop_star.tscn")


func _on_ricochet_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ricochet.tscn")
