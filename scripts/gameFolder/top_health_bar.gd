extends Sprite2D
@onready var game_over = $"../GameOver"
@onready var score = $"../Score"
@onready var highscore = $"../Highscore"
@onready var camera_2d = $"../Camera2D"

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
			score.visible = false
			highscore.visible = false
			
			firstTally = false
	else:
		firstTally = true
		score.visible = true
		highscore.visible = true
	
	if dying:
		Global.gameTimeScale -= delta
		if Global.gameTimeScale <= 0:
			Global.gameTimeScale = 0.0
