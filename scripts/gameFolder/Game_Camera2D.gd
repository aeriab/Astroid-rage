extends Camera2D
@onready var crasher_area_2d = $"../CrasherArea2D"

var orig_follow_speed: float = 20.0
var follow_speed: float = 70.0

var MAX: float = 30.0

func _process(delta):
	if Global.softCam:
		if position.x < crasher_area_2d.position.x - 5.0:
			if orig_follow_speed * delta * (position.x - crasher_area_2d.position.x) > MAX:
				position.x -= MAX
			elif orig_follow_speed * delta * (position.x - crasher_area_2d.position.x) < -MAX:
				position.x += MAX
			else:
				position.x -= orig_follow_speed * delta * (position.x - crasher_area_2d.position.x)
		elif position.x > crasher_area_2d.position.x + 5.0:
			if orig_follow_speed * delta * (position.x - crasher_area_2d.position.x) > MAX:
				position.x -= MAX
			elif orig_follow_speed * delta * (position.x - crasher_area_2d.position.x) < -MAX:
				position.x += MAX
			else:
				position.x -= orig_follow_speed * delta * (position.x - crasher_area_2d.position.x)
		
		if position.y < crasher_area_2d.position.y - 5.0:
			if orig_follow_speed * delta * (position.y - crasher_area_2d.position.y) > MAX:
				position.y -= MAX
			elif orig_follow_speed * delta * (position.y - crasher_area_2d.position.y) < -MAX:
				position.y += MAX
			else:
				position.y -= orig_follow_speed * delta * (position.y - crasher_area_2d.position.y)
		elif position.y > crasher_area_2d.position.y + 5.0:
			if orig_follow_speed * delta * (position.y - crasher_area_2d.position.y) > MAX:
				position.y -= MAX
			elif orig_follow_speed * delta * (position.y - crasher_area_2d.position.y) < -MAX:
				position.y += MAX
			else:
				position.y -= orig_follow_speed * delta * (position.y - crasher_area_2d.position.y)
	else:
		if position.x < crasher_area_2d.position.x - 5.0:
			position.x -= follow_speed * delta * Global.gameTimeScale * (position.x - crasher_area_2d.position.x)
		elif position.x > crasher_area_2d.position.x + 5.0:
			position.x -= follow_speed * delta * Global.gameTimeScale * (position.x - crasher_area_2d.position.x)
		
		if position.y < crasher_area_2d.position.y - 5.0:
			position.y -= follow_speed * delta * Global.gameTimeScale * (position.y - crasher_area_2d.position.y)
		elif position.y > crasher_area_2d.position.y + 5.0:
			position.y -= follow_speed * delta * Global.gameTimeScale * (position.y - crasher_area_2d.position.y)
