extends Label


func _process(_delta):
	text = "SCORE: " + str(Global.points) + " PTS"
