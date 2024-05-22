extends Control
@onready var text_number_xp = $textNumberXp

var textOfInterest: String
var currentColor: Color
var xpSize: float

func _ready():
	text_number_xp.text = str(int(xpSize * 10.0)) + " XP"
	currentColor = text_number_xp.get_theme_color("font_color")
	scale.y = xpSize
	scale.x = xpSize

func getXPSize(num):
	xpSize = num

func _process(delta):
	position.y -= (delta / (xpSize + 0.3)) * 200.0
	scale.x -= (delta + (xpSize - scale.x)) * 0.1
	scale.y -= (delta + (xpSize - scale.y)) * 0.1
	
	text_number_xp.add_theme_color_override("font_color", currentColor)
	if scale.x <= 0.01 || scale.y <= 0.01:
		queue_free()
