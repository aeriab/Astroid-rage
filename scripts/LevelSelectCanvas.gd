extends CanvasLayer
@onready var target_highscore = $TargetStars/TargetPractice/TargetHighscore
@onready var pop_highscore = $PopStarContainer/PopStarButton/PopHighscore

func _ready():
	target_highscore.text = "HIGHSCORE: " + str(Global.highscore) + " PTS"
	pop_highscore.text = "HIGHSCORE: " + str(Global.popHighscore) + " PTS"

func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")


func _on_target_practice_pressed():
	get_tree().change_scene_to_file("res://scenes/target_practice.tscn")


func _on_pop_star_button_pressed():
	get_tree().change_scene_to_file("res://scenes/pop_star.tscn")
