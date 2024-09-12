extends Area2D

var clockwise = 1
@export var pause_rot: bool
@export var starting_rot: float

@onready var mutation_part = $mutationPart
@onready var pop_sfx_player = $"../../PopSfxPlayer"
@onready var crasher = $"../../CrasherArea2D"

var eyelidHeight: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = (starting_rot / 360) * 2 * PI

var lastConsec: int = 0
@onready var lazy_lazer_top = $LazyLazerTop
@onready var lazy_lazer_mid = $LazyLazerMid
@onready var lazy_lazer_bot = $LazyLazerBot
@onready var lazer = $Lazer
@onready var lazy_on_eye = $LazyOnEye
@onready var cpu_particles_2d = $Lazer/CPUParticles2D
@onready var health_bar_red = $"../../HealthBarRed"

var lazer_width: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_up") && Global.gameTimeScale > 0.1 && !Global.startCrasher && !Global.impactSequence && Global.canDeployCrasher:
		Global.startCrasher = true
	
	
	if Global.consecBulls != lastConsec:
		mutation_part.setFire(Global.consecBulls)
		lastConsec = Global.consecBulls
	
	Global.prior_dir = clockwise
	if Input.is_action_pressed("switch") && Global.gameTimeScale > 0.1:
		cpu_particles_2d.emitting = true
		Global.rotationSpeed = 0.3
		lazer.position.x = 0
		lazy_on_eye.visible = true
		lazy_lazer_top.visible = true
		lazy_lazer_mid.visible = true
		lazy_lazer_bot.visible = true
		
		if lazer_width < 2.5:
			lazer_width += Global.gameTimeScale * delta * 10.0
		else:
			lazer_width = 2.5
		
		lazy_lazer_top.position.x += delta * Global.gameTimeScale * 6000
		lazy_lazer_mid.position.x += delta * Global.gameTimeScale * 6000
		lazy_lazer_bot.position.x += delta * Global.gameTimeScale * 6000
		
		if lazy_lazer_top.position.x > 9000:
			lazy_lazer_top.position.x -= 12220
		if lazy_lazer_mid.position.x > 9000:
			lazy_lazer_mid.position.x -= 12220
		if lazy_lazer_bot.position.x > 9000:
			lazy_lazer_bot.position.x -= 12220
		
		health_bar_red.firingLazer = true
		Global.player_health -= Global.gameTimeScale * delta * 2.0
		
	else:
		health_bar_red.firingLazer = false
		cpu_particles_2d.emitting = false
		Global.rotationSpeed = 2
		
		if lazer_width > 0.0:
			lazer_width -= Global.gameTimeScale * delta * 20.0
		else:
			lazer_width = 0.0
			lazer.position.x = 99000
			lazy_on_eye.visible = false
			lazy_lazer_top.visible = false
			lazy_lazer_mid.visible = false
			lazy_lazer_bot.visible = false
	
	lazy_lazer_top.scale.y = lazer_width
	lazy_lazer_mid.scale.y = lazer_width
	lazy_lazer_bot.scale.y = lazer_width
	lazer.scale.x = lazer_width / 2.5
	
	if !pause_rot:
		rotation += (Global.rotationSpeed * clockwise * delta * Global.gameTimeScale)
