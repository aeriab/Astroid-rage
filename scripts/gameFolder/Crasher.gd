extends Sprite2D
@onready var cpu_particles_2d = $CPUParticles2D

var clockwise: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var moveScale: float = 0.0
var moveAccel: float = 1000
var moveDeccel: float = 6000
var rotScale: float = 3.0
var rotAccel: float = 8.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	rotation += (Global.rotationSpeed * delta * Global.gameTimeScale * clockwise) * rotScale
	
	if Input.is_action_just_pressed("ui_up") && Global.gameTimeScale > 0.1:
		clockwise *= -1
	
	if Input.is_action_pressed("ui_up") && Global.gameTimeScale > 0.1:
		cpu_particles_2d.emitting = true
		if moveScale < 1800:
			moveScale += delta * moveAccel * Global.gameTimeScale
		else:
			moveScale = 1800
		
		rotScale = 0.0
	else:
		cpu_particles_2d.emitting = false
		if moveScale > 0:
			moveScale -= delta * moveDeccel * Global.gameTimeScale
		else:
			moveScale = 0
		
		if moveScale <= 0.01:
			if rotScale < 2.0:
				rotScale += delta * rotAccel * Global.gameTimeScale
			else:
				rotScale = 2.0
	
	position.x += delta * Global.gameTimeScale * moveScale * sin(rotation)
	position.y -= delta * Global.gameTimeScale * moveScale * cos(rotation)
