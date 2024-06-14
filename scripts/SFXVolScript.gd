extends AudioStreamPlayer

@export var startingDB: float

func _process(_delta):
	volume_db = AudioPreload.effectsVolDB + startingDB
