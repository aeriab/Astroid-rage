extends Node2D
@onready var store_page = $store_page


func _process(_delta):
	if Engine.time_scale == 0:
		store_page.tallyPoints()
		store_page.visible = true
		
	else:
		store_page.visible = false

func setFreeLater():
	queue_free()
