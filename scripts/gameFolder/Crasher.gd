extends Area2D
@onready var cpu_particles_2d = $Crasher/CPUParticles2D


var clockwise: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.crashTime <= 0:
		if firstCrashTimeout:
			Global.startCrasher = false
			Global.crashStarted = false
			cpu_particles_2d.emitting = false
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
		
		rotation += (Global.rotationSpeed * delta * Global.gameTimeScale * clockwise) * rotScale * speedScale
		
		if Input.is_action_just_pressed("ui_up") && Global.gameTimeScale > 0.1:
			clockwise *= -1
		
		if Input.is_action_pressed("ui_up") && Global.gameTimeScale > 0.1:
			cpu_particles_2d.emitting = true
			thrust = 150
			
			rotScale = 0.0
		else:
			cpu_particles_2d.emitting = false
			thrust = 0
			
			if force <= 5.0 && force >= -5.0:
				if rotScale < ROT_SCALE:
					rotScale += delta * rotAccel * Global.gameTimeScale * speedScale
				else:
					rotScale = ROT_SCALE
		
		
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
		cpu_particles_2d.emitting = false
		reset_stats()

func reset_stats():
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
