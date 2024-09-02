extends Sprite2D
@onready var game_over = $"../GameOver"
@onready var camera_2d = $"../Camera2D"
@onready var star_1 = $"../CanvasLayer/Star1"
@onready var star_2 = $"../CanvasLayer/Star2"
@onready var star_3 = $"../CanvasLayer/Star3"
@onready var star_4 = $"../CanvasLayer/Star4"
@onready var star_5 = $"../CanvasLayer/Star5"
@onready var star_6 = $"../CanvasLayer/Star6"
@onready var star_7 = $"../CanvasLayer/Star7"
@onready var crash_boost = $"../CanvasLayer/CrashBoost"

var MAX_X: float = 1200
var MAX_Y: float = 750

var firstTally: bool = true

var dying: bool = false



func _process(delta):
	
	if camera_2d.position.x > MAX_X:
		position.x = camera_2d.position.x - MAX_X
	elif camera_2d.position.x < -MAX_X:
		position.x = camera_2d.position.x + MAX_X
	else:
		position.x = 0
	
	if camera_2d.position.y - 500 > MAX_Y:
		position.y = camera_2d.position.y - MAX_Y
	elif camera_2d.position.y - 500 < -MAX_Y:
		position.y = camera_2d.position.y + MAX_Y
	else:
		position.y = 500
	
	material.set_shader_parameter("health_value",Global.player_health)
	if Global.player_health <= 0:
		if firstTally:
			Global.gameOver = true
			dying = true
			game_over.visible = true
			game_over.tallyScores()
			star_1.visible = false
			star_2.visible = false
			star_3.visible = false
			star_4.visible = false
			star_5.visible = false
			star_6.visible = false
			star_7.visible = false
			crash_boost.visible = false
			
			firstTally = false
	else:
		firstTally = true
		crash_boost.visible = true
	
	if dying:
		Global.gameTimeScale -= delta
		if Global.gameTimeScale <= 0:
			Global.gameTimeScale = 0.0

