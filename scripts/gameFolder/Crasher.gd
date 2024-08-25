extends Sprite2D
@onready var cpu_particles_2d = $CPUParticles2D

var clockwise: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speedScale: float = 4.0

var moveScale: float = 0.0
var moveAccel: float = 1000
var moveDeccel: float = 6000
var rotScale: float = 1.0
var rotAccel: float = 8.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !Global.startCrasher:
	
		rotation += (Global.rotationSpeed * delta * Global.gameTimeScale * clockwise) * rotScale * speedScale
		
		if Input.is_action_just_pressed("ui_up") && Global.gameTimeScale > 0.1:
			clockwise *= -1
		
		if Input.is_action_pressed("ui_up") && Global.gameTimeScale > 0.1:
			cpu_particles_2d.emitting = true
			if moveScale < 1500:
				moveScale += delta * moveAccel * Global.gameTimeScale * speedScale
			else:
				moveScale = 1500
			
			rotScale = 0.0
		else:
			cpu_particles_2d.emitting = false
			if moveScale > 0:
				moveScale -= delta * moveDeccel * Global.gameTimeScale * speedScale
			else:
				moveScale = 0
			
			if moveScale <= 0.01:
				if rotScale < 1.0:
					rotScale += delta * rotAccel * Global.gameTimeScale * speedScale
				else:
					rotScale = 1.0
		
		position.x += delta * Global.gameTimeScale * moveScale * sin(rotation) * speedScale
		position.y -= delta * Global.gameTimeScale * moveScale * cos(rotation) * speedScale
