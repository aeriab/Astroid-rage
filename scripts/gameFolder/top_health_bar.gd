extends Sprite2D
@onready var game_over = $"../GameOver"
@onready var score = $"../Score"
@onready var highscore = $"../Highscore"


var firstTally: bool = true

var dying: bool = false

func _process(_delta):
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
		Global.gameTimeScale = Global.gameTimeScale - 0.01
		if Global.gameTimeScale <= 0:
			Global.gameTimeScale = 0.0
			dying = false
