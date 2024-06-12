extends Control
@onready var splatcho_volume_slider = $SplatchoVolumeSlider
@onready var h_slider = $HSlider

func _ready():
	setMusicVol(AudioPreload.effectsVolValue)
	h_slider.value = AudioPreload.effectsVolValue

func _on_h_slider_value_changed(value):
	setMusicVol(value)

func setMusicVol(value):
	#AudioPreload.volume_db = log(value / 100) * 20.0 + 5.0
	AudioPreload.effectsVolValue = value
	AudioPreload.effectsVolDB = log(value / 100) * 20.0 + 5.0
	if value <= 0:
		splatcho_volume_slider.texture = preload("res://assets/VolumeSprites/Splatcho Volume Slider (4).png")
	elif value <= 25:
		splatcho_volume_slider.texture = preload("res://assets/VolumeSprites/Splatcho Volume Slider (3).png")
	elif value <= 50:
		splatcho_volume_slider.texture = preload("res://assets/VolumeSprites/Splatcho Volume Slider (2).png")
	elif value <= 75:
		splatcho_volume_slider.texture = preload("res://assets/VolumeSprites/Splatcho Volume Slider (1).png")
	elif value < 100:
		splatcho_volume_slider.texture = preload("res://assets/VolumeSprites/Splatcho Volume Slider.png")
	else:
		splatcho_volume_slider.texture = preload("res://assets/VolumeSprites/Splatcho Volume Slider (6).png")
