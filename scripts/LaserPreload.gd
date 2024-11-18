extends AudioStreamPlayer

func play_laser():
	volume_db = AudioPreload.effectsVolDB
	play()

func pause_laser():
	stop()

