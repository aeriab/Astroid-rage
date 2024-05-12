extends Label

func _process(_delta):
	text = "ENEMIES LEFT: " + str(Global.enemyNum)
