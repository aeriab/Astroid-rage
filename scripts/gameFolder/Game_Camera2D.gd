extends Camera2D
@onready var drone

var orig_follow_speed: float = 20.0
var follow_speed: float = 70.0

var MAX: float = 30.0

func _ready():
	if Global.curDroneNumber == 1:
		drone = $"../CrasherArea2D"
	elif Global.curDroneNumber == 2:
		drone = $"../SprayNode2D/Spray"
	elif Global.curDroneNumber == 3:
		drone = $"../FlingNode2D/Fling"


func _process(delta):
	if Global.softCam:
		if position.x < drone.position.x - 5.0:
			Global.camXSet = false
			if orig_follow_speed * delta * (position.x - drone.position.x) > MAX:
				position.x -= MAX
			elif orig_follow_speed * delta * (position.x - drone.position.x) < -MAX:
				position.x += MAX
			else:
				position.x -= orig_follow_speed * delta * (position.x - drone.position.x)
		elif position.x > drone.position.x + 5.0:
			Global.camXSet = false
			if orig_follow_speed * delta * (position.x - drone.position.x) > MAX:
				position.x -= MAX
			elif orig_follow_speed * delta * (position.x - drone.position.x) < -MAX:
				position.x += MAX
			else:
				position.x -= orig_follow_speed * delta * (position.x - drone.position.x)
		else:
			Global.camXSet = true
		
		if position.y < drone.position.y - 5.0:
			Global.camYSet = false
			if orig_follow_speed * delta * (position.y - drone.position.y) > MAX:
				position.y -= MAX
			elif orig_follow_speed * delta * (position.y - drone.position.y) < -MAX:
				position.y += MAX
			else:
				position.y -= orig_follow_speed * delta * (position.y - drone.position.y)
		elif position.y > drone.position.y + 5.0:
			Global.camYSet = false
			if orig_follow_speed * delta * (position.y - drone.position.y) > MAX:
				position.y -= MAX
			elif orig_follow_speed * delta * (position.y - drone.position.y) < -MAX:
				position.y += MAX
			else:
				position.y -= orig_follow_speed * delta * (position.y - drone.position.y)
		else:
			Global.camYSet = true
	else:
		if position.x < drone.position.x - 5.0:
			position.x -= follow_speed * delta * Global.gameTimeScale * (position.x - drone.position.x)
		elif position.x > drone.position.x + 5.0:
			position.x -= follow_speed * delta * Global.gameTimeScale * (position.x - drone.position.x)
		
		if position.y < drone.position.y - 5.0:
			position.y -= follow_speed * delta * Global.gameTimeScale * (position.y - drone.position.y)
		elif position.y > drone.position.y + 5.0:
			position.y -= follow_speed * delta * Global.gameTimeScale * (position.y - drone.position.y)
