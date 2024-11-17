extends Area2D
@onready var cpu_particles_2d = $GobSprite/CPUParticles2D
const DECAYING_GREEN_SPOT = preload("res://scenes/boogers/decaying_booger_area.tscn")

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
	#scale.x = 0.65 + Global.num_drone_stars1 * 0.15
	#scale.y = 0.65 + Global.num_drone_stars1 * 0.15
	
	MAX_THRUST = (30.0 * Global.num_drone_stars2) + 100.0
	
	ROT_UPGRADER = (0.15 * Global.num_drone_stars5) + 1.5
	
	crashTimeScale = -(Global.num_drone_stars3 * 0.3) + 4.0

var sinFunctionProg: float = 0.0
var firstTimeMoving: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !Global.startCrasher && Global.crashStarted && firstTimeMoving:
		cpu_particles_2d.emitting = true
		sinFunctionProg = rotation
		firstTimeMoving = false
	
	if !Global.crashStarted:
		firstTimeMoving = true
	
	
	if sinFunctionProg < 2 * PI:
		sinFunctionProg += delta * Global.gameTimeScale * 40.0
	else:
		sinFunctionProg = 0.0
	
	if Global.crashTime <= 0:
		if firstCrashTimeout:
			Global.startCrasher = false
			Global.crashStarted = false
			cpu_particles_2d.emitting = false
			reset_stats()
			firstCrashTimeout = false
			Global.gameTimeScale = 0.0
			
			var i: int = 0
			var theta: float = 0.0
			while i < int(Global.num_drone_stars1 * 40) + 80:
				var greenspot = DECAYING_GREEN_SPOT.instantiate()
				get_parent().add_child.call_deferred(greenspot)
				var x1: float = position.x
				var y1: float = position.y
				
				var snout_length = sqrt((x1 * x1) + (y1 * y1))
				
				if y1 < 0:
					theta = acos(x1 / snout_length) + randf_range(-PI,PI)
				else:
					theta = 2 * PI -  acos(x1 / snout_length)  + randf_range(-PI,PI)
				
				greenspot.set_motion(x1,y1,theta,1,1.0/((Global.num_drone_stars1 * 0.8) + 1.5))
				i += 1
			Global.enemiesOnGob = 0
	
	if Global.gameOver:
		Global.softCam = true
		position.x = 0
		position.y = 0
	
	if !Global.startCrasher && Global.crashStarted && !Global.gameOver:
		firstCrashTimeout = true
		if Global.crashTime > 0:
			Global.crashTime -= crashTimeScale * delta * Global.gameTimeScale
		
		if Input.is_action_just_pressed("ui_up"):
			if clockwise > 0:
				sinFunctionProg = PI
			else:
				sinFunctionProg = 0.0
			
			clockwise = clockwise * -1
		
		if Input.is_action_pressed("ui_up") && Global.gameTimeScale > 0.1:
			thrust = MAX_THRUST * 1.8
			if Input.is_action_pressed("ui_right"):
				rotation += Global.gameTimeScale * delta * 10.0
			elif Input.is_action_pressed("ui_left"):
				rotation -= Global.gameTimeScale * delta * 10.0
			else:
				rotation += sin(sinFunctionProg) * Global.gameTimeScale * delta * 5.0
		else:
			thrust = MAX_THRUST
			if Input.is_action_pressed("ui_right"):
				rotation += Global.gameTimeScale * delta * 10.0
			elif Input.is_action_pressed("ui_left"):
				rotation -= Global.gameTimeScale * delta * 10.0
		
		
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
		Global.gobXMovement = delta * Global.gameTimeScale * force * sin(rotation) * speedScale
		Global.gobYMovement = -(delta * Global.gameTimeScale * force * cos(rotation) * speedScale)
		
		length_out = sqrt((position.x * position.x) + (position.y * position.y))
		
		if position.y < 0:
			top_rotation = acos(position.x / length_out)
		else:
			top_rotation = 2 * PI -  acos(position.x / length_out)
		
		if length_out > 4800:
			position.x -= delta * Global.gameTimeScale * inPull * sin(top_rotation + PI/2) * (length_out - 4800)
			position.y -= delta * Global.gameTimeScale * inPull * cos(top_rotation + PI/2) * (length_out - 4800)
			Global.gobXMovement -= delta * Global.gameTimeScale * inPull * sin(top_rotation + PI/2) * (length_out - 4800)
			Global.gobYMovement -= delta * Global.gameTimeScale * inPull * cos(top_rotation + PI/2) * (length_out - 4800)

func _on_area_entered(area):
	if area.is_in_group("Player") && Global.crashStarted && !Global.startCrasher && Global.crashTime > 0:
		Global.startCrasher = false
		Global.crashStarted = false
		Global.impactSequence = true
		cpu_particles_2d.emitting = false
		reset_stats()

func reset_stats():
	Global.enemiesOnGob = 0
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

func boundBounceBack():
	
	var realMathAngle: float
	var boundTheta: float
	if position.y < 0:
		boundTheta = acos(position.x / sqrt(pow(position.x,2) + pow(position.y,2)))
	else:
		boundTheta = -acos(position.x / sqrt(pow(position.x,2) + pow(position.y,2)))
	
	realMathAngle = -rotation + PI/2
	
	realMathAngle = realMathAngle - ((realMathAngle - PI) - (2 * ((boundTheta - PI) + PI/2) - (realMathAngle - PI)))
	
	rotation = -(realMathAngle - PI/2)

func bounceBack(xenemy,yenemy):
	var bounceAngle = 0.0
	var difX = position.x - xenemy
	var difY = position.y - yenemy
	var collide_length = sqrt((difX * difX) + (difY * difY))
	if difY < 0:
		bounceAngle = acos(difX / collide_length)
	else:
		bounceAngle = 2 * PI -  acos(difX / collide_length)
	var realMathAngle: float
	realMathAngle = -rotation + PI/2
	realMathAngle = realMathAngle - ((realMathAngle - PI) - (2 * ((bounceAngle - PI) + PI/2) - (realMathAngle - PI)))
	
	rotation = -(realMathAngle - PI/2)

func explodeGob():
	if firstCrashTimeout:
		Global.startCrasher = false
		Global.crashStarted = false
		cpu_particles_2d.emitting = false
		reset_stats()
		firstCrashTimeout = false
		Global.gameTimeScale = 0.0
		
		var i: int = 0
		var theta: float = 0.0
		while i < int(Global.num_drone_stars1 * 40) + 80:
			var greenspot = DECAYING_GREEN_SPOT.instantiate()
			get_parent().add_child.call_deferred(greenspot)
			var x1: float = position.x
			var y1: float = position.y
			
			var snout_length = sqrt((x1 * x1) + (y1 * y1))
			
			if y1 < 0:
				theta = acos(x1 / snout_length) + randf_range(-PI,PI)
			else:
				theta = 2 * PI -  acos(x1 / snout_length)  + randf_range(-PI,PI)
			
			greenspot.set_motion(x1,y1,theta,1,1.0/((Global.num_drone_stars1 * 0.8) + 1.5))
			i += 1
		Global.enemiesOnGob = 0
	


