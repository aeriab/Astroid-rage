extends CanvasLayer
var countingScore: bool = false
var curTally: int = 0

@onready var score = $Score
@onready var highscore = $Highscore
@onready var score_cpu_particles_2d = $Score/ScoreCPUParticles2D
@onready var highscore_cpu_particles_2d = $Highscore/HighscoreCPUParticles2D
@onready var earning_points = $EarningPoints
@onready var earning_timer = $EarningPoints/EarningTimer
@onready var highscore_awarded = $HighscoreAwarded
@onready var dark_star_particle_1 = $StarCompletes/DarkStarParticle1
@onready var dark_star_particle_2 = $StarCompletes/DarkStarParticle2
@onready var dark_star_particle_3 = $StarCompletes/DarkStarParticle3
@onready var dark_star_particle_4 = $StarCompletes/DarkStarParticle4
@onready var dark_star_particle_5 = $StarCompletes/DarkStarParticle5
@onready var dark_star_particle_6 = $StarCompletes/DarkStarParticle6
@onready var dark_star_particle_7 = $StarCompletes/DarkStarParticle7
@onready var star_sound_1 = $StarSound1
@onready var star_sound_2 = $StarSound2
@onready var star_sound_3 = $StarSound3
@onready var star_sound_4 = $StarSound4
@onready var star_sound_5 = $StarSound5
@onready var star_sound_6 = $StarSound6
@onready var star_sound_7 = $StarSound7
@onready var star_cpu_particles_1 = $StarCompletes/DarkStarParticle1/StarCPUParticles1
@onready var star_cpu_particles_2 = $StarCompletes/DarkStarParticle2/StarCPUParticles2
@onready var star_cpu_particles_3 = $StarCompletes/DarkStarParticle3/StarCPUParticles3
@onready var star_cpu_particles_4 = $StarCompletes/DarkStarParticle4/StarCPUParticles4
@onready var star_cpu_particles_5 = $StarCompletes/DarkStarParticle5/StarCPUParticles5
@onready var star_cpu_particles_6 = $StarCompletes/DarkStarParticle6/StarCPUParticles6
@onready var star_cpu_particles_7 = $StarCompletes/DarkStarParticle7/StarCPUParticles7

@onready var ghost_star_particle_1 = $StarGhosts/GhostStarParticle1
@onready var ghost_star_particle_2 = $StarGhosts/GhostStarParticle2
@onready var ghost_star_particle_3 = $StarGhosts/GhostStarParticle3
@onready var ghost_star_particle_4 = $StarGhosts/GhostStarParticle4
@onready var ghost_star_particle_5 = $StarGhosts/GhostStarParticle5
@onready var ghost_star_particle_6 = $StarGhosts/GhostStarParticle6
@onready var ghost_star_particle_7 = $StarGhosts/GhostStarParticle7

var firstS1: bool = true
var firstS2: bool = true
var firstS3: bool = true
var firstS4: bool = true
var firstS5: bool = true
var firstS6: bool = true
var firstS7: bool = true

var lastTally: int = 0

func _process(_delta):
	
	if countingScore:
		score_cpu_particles_2d.emitting = true
		curTally += int(Global.points / 300.0) + 10
		score.text = "SCORE: " + str(curTally) + " PTS"
		
		if curTally >= Global.curS1 && firstS1:
			dark_star_particle_1.visible = true
			ghost_star_particle_1.visible = true
			star_sound_1.play()
			star_cpu_particles_1.emitting = true
			firstS1 = false
			
		if curTally >= Global.curS2 && firstS2:
			dark_star_particle_2.visible = true
			ghost_star_particle_2.visible = true
			star_sound_2.play()
			star_cpu_particles_2.emitting = true
			firstS2 = false
			
		if curTally >= Global.curS3 && firstS3:
			dark_star_particle_3.visible = true
			ghost_star_particle_3.visible = true
			star_sound_3.play()
			star_cpu_particles_3.emitting = true
			firstS3 = false
			
		if curTally >= Global.curS4 && firstS4:
			dark_star_particle_4.visible = true
			ghost_star_particle_4.visible = true
			star_sound_4.play()
			star_cpu_particles_4.emitting = true
			firstS4 = false
			
		if curTally >= Global.curS5 && firstS5:
			dark_star_particle_5.visible = true
			ghost_star_particle_5.visible = true
			star_sound_5.play()
			star_cpu_particles_5.emitting = true
			firstS5 = false
			
		if curTally >= Global.curS6 && firstS6:
			dark_star_particle_6.visible = true
			ghost_star_particle_6.visible = true
			star_sound_6.play()
			star_cpu_particles_6.emitting = true
			firstS6 = false
			
		if curTally >= Global.curS7 && firstS7:
			dark_star_particle_7.visible = true
			ghost_star_particle_7.visible = true
			star_sound_7.play()
			star_cpu_particles_7.emitting = true
			firstS7 = false
		
		
		if earning_timer.is_stopped():
			earning_timer.start()
		
		if curTally >= Global.points:
			score_cpu_particles_2d.emitting = false
			curTally = Global.points
			score.text = "SCORE: " + str(curTally) + " PTS"
			countingScore = false
			
			if Global.points >= Global.curHighscore:
				highscore.text = "HIGHSCORE: " + str(Global.points) + " PTS"
				highscore_cpu_particles_2d.emitting = true
				highscore_awarded.play()


func tallyScores():
	highscore.text = "HIGHSCORE: " + str(Global.curHighscore) + " PTS"
	countingScore = true
	
	if Global.curHighscore >= Global.curS1:
		ghost_star_particle_1.visible = true
	if Global.curHighscore >= Global.curS2:
		ghost_star_particle_2.visible = true
	if Global.curHighscore >= Global.curS3:
		ghost_star_particle_3.visible = true
	if Global.curHighscore >= Global.curS4:
		ghost_star_particle_4.visible = true
	if Global.curHighscore >= Global.curS5:
		ghost_star_particle_5.visible = true
	if Global.curHighscore >= Global.curS6:
		ghost_star_particle_6.visible = true
	if Global.curHighscore >= Global.curS7:
		ghost_star_particle_7.visible = true

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	Global.resetStats()
	visible = false
	Global.gameOver = false
	Global.gameTimeScale = 1.0

func _on_stage_button_pressed():
	Global.gameOver = false
	Global.gameTimeScale = 1.0
	Global.resetStats()
	get_tree().change_scene_to_file("res://scenes/playable_scenes/stage_select.tscn")

func _on_earning_timer_timeout():
	earning_points.pitch_scale = randf_range(0.7,1.3)
	earning_points.play()
	earning_timer.stop()

func three_star_level():
	dark_star_particle_1.visible = false
	dark_star_particle_2.visible = false
	dark_star_particle_3.visible = true
	dark_star_particle_4.visible = true
	dark_star_particle_5.visible = true
	dark_star_particle_6.visible = false
	dark_star_particle_7.visible = false

func five_star_level():
	dark_star_particle_1.visible = false
	dark_star_particle_2.visible = true
	dark_star_particle_3.visible = true
	dark_star_particle_4.visible = true
	dark_star_particle_5.visible = true
	dark_star_particle_6.visible = true
	dark_star_particle_7.visible = false

func seven_star_level():
	dark_star_particle_1.visible = true
	dark_star_particle_2.visible = true
	dark_star_particle_3.visible = true
	dark_star_particle_4.visible = true
	dark_star_particle_5.visible = true
	dark_star_particle_6.visible = true
	dark_star_particle_7.visible = true
