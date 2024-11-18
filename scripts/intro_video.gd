extends CanvasLayer

@onready var video_stream_player = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	
	video_stream_player.volume_db = AudioPreload.effectsVolDB
	
	AudioPreload.play_intro_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if AudioPreload.playingIntro == false:
		get_tree().change_scene_to_file("res://scenes/playable_scenes/stage_select.tscn")
