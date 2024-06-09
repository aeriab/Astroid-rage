extends Control
@onready var text_label = $textLabel

var tsize: float = 1.0
var ttext: String = " "
var tclr: Color = Color.BLACK
var fadeSpeed: float = 0.001
var degreesClockwise: float = 0.0

func _ready():
	text_label.text = ttext
	text_label.add_theme_color_override("font_color", tclr)
	scale.x = tsize
	scale.y = tsize

func establishText(txt,sze,clr,fdspd,degoff):
	ttext = txt
	tsize = sze
	tclr = clr
	fadeSpeed = fdspd
	degreesClockwise = degoff

func _process(delta):
	position.y -= (delta / (tsize + 0.3)) * 200.0
	scale.x -= (delta + (tsize - scale.x)) * fadeSpeed
	scale.y -= (delta + (tsize - scale.y)) * fadeSpeed
	
	rotation = (degreesClockwise / 360) * 2 * PI
	
	if scale.x <= 0.01 || scale.y <= 0.01:
		queue_free()
