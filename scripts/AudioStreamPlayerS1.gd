extends AudioStreamPlayer

const _47 = preload("res://assets/trainingSongOne/4758872798134272.wav")
const _53 = preload("res://assets/trainingSongOne/5388408074141696.wav")
const _54 = preload("res://assets/trainingSongOne/5452190569857024.wav")
const _59 = preload("res://assets/trainingSongOne/5946900010893312.wav")

var lastTrack: int = 99
var volValue: int = 52
var effectsVolValue: int = 52
var effectsVolDB: float = 0.0


func _ready():
	var i: int = randi_range(0,3)
	if i == 0:
		stream = _47
	elif i == 1:
		stream = _53
	elif i == 2:
		stream = _54
	elif i == 3:
		stream = _59
	lastTrack = i
	play()

func _on_finished():
	var i: int = randi_range(0,3)
	
	while i == lastTrack:
		i = randi_range(0,3)
	
	if i == 0:
		stream = _47
	elif i == 1:
		stream = _53
	elif i == 2:
		stream = _54
	elif i == 3:
		stream = _59
	
	lastTrack = i
	
	play()

func volChange(vol):
	
	volume_db = vol
