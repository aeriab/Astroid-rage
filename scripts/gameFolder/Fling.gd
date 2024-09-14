extends Area2D

var clockwise: float = 1

var speedScale: float = 4.0

var force: float = 0.0
var thrust: float = 0.0
var resistance: float = 0.05
var fric: float = 30.0

var inPull: float = 50.0

var moveScale: float = 0.0
var moveAccel: float = 1000
var moveDeccel: float = 6000
var ROT_SCALE: float = 2.0
var rotScale: float = 0.0
var rotAccel: float = 8.0

var crashTimeScale: float = 4.0

var top_rotation: float = 0.0
var length_out: float = 0.0

var firstCrashTimeout: bool = true

var MAX_THRUST: float = 150.0
var ROT_UPGRADER: float = 1.0

func _ready():
	scale.x = 0.65 + Global.num_drone_stars1 * 0.15
	scale.y = 0.65 + Global.num_drone_stars1 * 0.15
	
	MAX_THRUST = (30.0 * Global.num_drone_stars2) + 100.0
	
	ROT_UPGRADER = (0.15 * Global.num_drone_stars3) + 1.5
	
	crashTimeScale = -(Global.num_drone_stars4 * 0.7) + 2.0
	
	

@onready var fling_outline = $"../FlingOutline"
@onready var fling_back_sprite = $"../FlingBackSprite"
var rotBuildup: float = 0.0
var curRotBuildup: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fling_outline.position = position
	fling_outline.scale = scale * 0.3
	fling_back_sprite.position = position
	fling_back_sprite.scale = scale * 0.3
	
	
	
	if Global.crashTime <= 0:
		if firstCrashTimeout:
			Global.startCrasher = false
			Global.crashStarted = false
			reset_stats()
			firstCrashTimeout = false
			Global.gameTimeScale = 0.0
	
	if Global.gameOver:
		Global.softCam = true
		position.x = 0
		position.y = 0
	
	if !Global.startCrasher && Global.crashStarted && !Global.gameOver:
		firstCrashTimeout = true
		if Global.crashTime > 0:
			Global.crashTime -= crashTimeScale * delta * Global.gameTimeScale
		
		rotation += (delta * Global.gameTimeScale * clockwise) * rotScale * speedScale * ROT_UPGRADER
		
		if Input.is_action_just_released("ui_up") && Global.gameTimeScale > 0.1:
			curRotBuildup = rotBuildup
		
		thrust = MAX_THRUST * curRotBuildup * 3
		if rotBuildup > 0.0:
			rotBuildup -= 0.04
		else:
			rotBuildup = 0.0
		fling_back_sprite.rotate(Global.gameTimeScale * delta * rotBuildup * 30)
		if curRotBuildup > 0.0:
			curRotBuildup -= 0.04
		else:
			curRotBuildup = 0.0
		if Input.is_action_pressed("ui_up") && Global.gameTimeScale > 0.1:
			if curRotBuildup < 0.5:
				if rotBuildup < 10.0:
					rotBuildup += 0.07
				else:
					rotBuildup = 10.0
			
			rotScale = 0.0
		else:
			if force <= 5.0 && force >= -5.0:
				if rotScale < ROT_SCALE * ROT_UPGRADER:
					rotScale += delta * rotAccel * Global.gameTimeScale * speedScale * ROT_UPGRADER
				else:
					rotScale = ROT_SCALE * ROT_UPGRADER
		
		
		force += thrust
		
		if force > 0:
			force -= force * resistance + fric
			if force < 0:
				force = 0
		else:
			force += force * resistance + fric
			if force > 0:
				force = 0
		
		position.x += delta * Global.gameTimeScale * force * sin(rotation) * speedScale
		position.y -= delta * Global.gameTimeScale * force * cos(rotation) * speedScale
		
		length_out = sqrt((position.x * position.x) + (position.y * position.y))
		
		if position.y < 0:
			top_rotation = acos(position.x / length_out)
		else:
			top_rotation = 2 * PI -  acos(position.x / length_out)
		
		if length_out > 4400:
			position.x -= delta * Global.gameTimeScale * inPull * sin(top_rotation + PI/2) * (length_out - 4400)
			position.y -= delta * Global.gameTimeScale * inPull * cos(top_rotation + PI/2) * (length_out - 4400)

func _on_area_entered(area):
	if area.is_in_group("Player") && Global.crashStarted && !Global.startCrasher && Global.crashTime > 0:
		Global.startCrasher = false
		Global.crashStarted = false
		Global.impactSequence = true
		reset_stats()

func reset_stats():
	rotBuildup = 0.0
	curRotBuildup = 0.0
	speedScale = 4.0
	force = 0.0
	thrust = 0.0
	resistance = 0.05
	fric = 30.0
	inPull = 50.0
	moveScale = 0.0
	moveAccel = 1000
	moveDeccel = 6000
	ROT_SCALE = 2.0
	rotScale = 0.0
	rotAccel = 8.0
	top_rotation = 0.0
	length_out = 0.0

func bounceBack(xboss,yboss):
	var bounceAngle = 0.0
	var difX = position.x - xboss
	var difY = position.y - yboss
	var collide_length = sqrt((difX * difX) + (difY * difY))
	if difY < 0:
		bounceAngle = acos(difX / collide_length)
	else:
		bounceAngle = 2 * PI -  acos(difX / collide_length)
	rotation = -(bounceAngle - (PI/2))
	force = 5000
