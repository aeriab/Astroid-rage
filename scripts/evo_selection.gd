extends CanvasLayer

@onready var evo_title = $evoTitle
@onready var flash_timer = $FlashTimer
@onready var mutate_button = $MutateButton
@onready var cpu_particles_2d = $CPUParticles2D

var startFlash: bool = false
var endFlash: bool = false
var textColor: Color = Color.BLACK
var buttonColor: Color = Color.WHITE

@onready var color_rect = $ColorRect


func _process(delta):
	if Global.mutateNumber >= 8:
		color_rect.visible = true
	
	if startFlash:
		textColor.b += delta * 2.0
		buttonColor.r -= delta * 2.0
		buttonColor.g -= delta * 2.0
		if textColor.b >= 0.9:
			cpu_particles_2d.emitting = true
			startFlash = false
			endFlash = true
		evo_title.add_theme_color_override("font_color",textColor)
		mutate_button.modulate = buttonColor
	elif endFlash:
		textColor.b -= delta
		buttonColor.r += delta
		buttonColor.g += delta
		if textColor.b <= 0.001:
			textColor.b = 0.0
			endFlash = false
		evo_title.add_theme_color_override("font_color",textColor)
		mutate_button.modulate = buttonColor

func _on_mutate_button_pressed():
	Global.mutateNumber += 1
	Global.evolutionPoints -= 1

func evoSelectStart():
	flash_timer.start()

func evoSelectFinish():
	flash_timer.stop()
	startFlash = false
	endFlash = false
	textColor = Color.BLACK
	evo_title.add_theme_color_override("font_color",textColor)
	buttonColor = Color.WHITE
	mutate_button.modulate = buttonColor
	scale.x = 1.0
	scale.y = 1.0

func _on_flash_timer_timeout():
	startFlash = true
