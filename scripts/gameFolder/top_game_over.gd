extends CanvasLayer
var countingScore: bool = false
var curTally: int = 0

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

@onready var outline_star_particle_1 = $StarOutlines/DarkStarParticle1
@onready var outline_star_particle_2 = $StarOutlines/DarkStarParticle2
@onready var outline_star_particle_3 = $StarOutlines/DarkStarParticle3
@onready var outline_star_particle_4 = $StarOutlines/DarkStarParticle4
@onready var outline_star_particle_5 = $StarOutlines/DarkStarParticle5
@onready var outline_star_particle_6 = $StarOutlines/DarkStarParticle6
@onready var outline_star_particle_7 = $StarOutlines/DarkStarParticle7
@onready var over_words = $OverWords


@onready var stage_name = $StageName

var firstS1: bool = true
var firstS2: bool = true
var firstS3: bool = true
var firstS4: bool = true
var firstS5: bool = true
var firstS6: bool = true
var firstS7: bool = true

var lastTally: int = 0

var starCounter: int = 0

func _ready():
	stage_name.text = Global.current_stage
	
	if Global.waveNum == 3:
		three_star_level()
		starCounter = 2
	elif Global.waveNum == 5:
		five_star_level()
		starCounter = 1
	elif Global.waveNum == 7:
		seven_star_level()
		starCounter = 0

func awardS1():
	dark_star_particle_1.visible = true
	ghost_star_particle_1.visible = true
	star_sound_1.play()
	star_cpu_particles_1.emitting = true
	firstS1 = false

func awardS2():
	dark_star_particle_2.visible = true
	ghost_star_particle_2.visible = true
	star_sound_2.play()
	star_cpu_particles_2.emitting = true
	firstS2 = false

func awardS3():
	dark_star_particle_3.visible = true
	ghost_star_particle_3.visible = true
	star_sound_3.play()
	star_cpu_particles_3.emitting = true
	firstS3 = false

func awardS4():
	dark_star_particle_4.visible = true
	ghost_star_particle_4.visible = true
	star_sound_4.play()
	star_cpu_particles_4.emitting = true
	firstS4 = false

func awardS5():
	dark_star_particle_5.visible = true
	ghost_star_particle_5.visible = true
	star_sound_5.play()
	star_cpu_particles_5.emitting = true
	firstS5 = false

func awardS6():
	dark_star_particle_6.visible = true
	ghost_star_particle_6.visible = true
	star_sound_6.play()
	star_cpu_particles_6.emitting = true
	firstS6 = false

func awardS7():
	dark_star_particle_7.visible = true
	ghost_star_particle_7.visible = true
	star_sound_7.play()
	star_cpu_particles_7.emitting = true
	firstS7 = false

@onready var star_1 = $"../CanvasLayer/Star1"
@onready var star_2 = $"../CanvasLayer/Star2"
@onready var star_3 = $"../CanvasLayer/Star3"
@onready var star_4 = $"../CanvasLayer/Star4"
@onready var star_5 = $"../CanvasLayer/Star5"
@onready var star_6 = $"../CanvasLayer/Star6"
@onready var star_7 = $"../CanvasLayer/Star7"
@onready var crash_boost = $"../CanvasLayer/CrashBoost"
var dying: bool = false
var firstComEnd: bool = true

func commenceEnd():
	Global.gameOver = true
	visible = true
	tallyScores()
	star_1.visible = false
	star_2.visible = false
	star_3.visible = false
	star_4.visible = false
	star_5.visible = false
	star_6.visible = false
	star_7.visible = false
	crash_boost.visible = false
	dying = true
	firstComEnd = false

func _process(delta):
	if dying:
		Global.gameTimeScale -= delta
		if Global.gameTimeScale <= 0:
			Global.gameTimeScale = 0.0
			dying = false
	
	if Global.waveNum == 3 && Global.fifthWaveProgress > 100 && firstComEnd:
		over_words.text = "Victory"
		commenceEnd()
	elif Global.waveNum == 5 && Global.sixthWaveProgress > 100 && firstComEnd:
		over_words.text = "Victory"
		visible = true
		commenceEnd()
	elif Global.waveNum == 7 && Global.seventhWaveProgress > 100 && firstComEnd:
		over_words.text = "Victory"
		visible = true
		commenceEnd()



@onready var star_award = $StarAward

func tallyScores():
	star_award.start()
	print("made here")

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

func three_star_level():
	outline_star_particle_1.visible = false
	outline_star_particle_2.visible = false
	outline_star_particle_3.visible = true
	outline_star_particle_4.visible = true
	outline_star_particle_5.visible = true
	outline_star_particle_6.visible = false
	outline_star_particle_7.visible = false

func five_star_level():
	outline_star_particle_1.visible = false
	outline_star_particle_2.visible = true
	outline_star_particle_3.visible = true
	outline_star_particle_4.visible = true
	outline_star_particle_5.visible = true
	outline_star_particle_6.visible = true
	outline_star_particle_7.visible = false

func seven_star_level():
	outline_star_particle_1.visible = true
	outline_star_particle_2.visible = true
	outline_star_particle_3.visible = true
	outline_star_particle_4.visible = true
	outline_star_particle_5.visible = true
	outline_star_particle_6.visible = true
	outline_star_particle_7.visible = true


func _on_star_award_timeout():
	starCounter += 1
	if starCounter == 1 && Global.firstWaveProgress > 100:
		awardS1()
	elif starCounter == 2 && Global.secondWaveProgress > 100:
		awardS2()
	elif starCounter == 3 && Global.thirdWaveProgress > 100:
		awardS3()
	elif starCounter == 4 && Global.fourthWaveProgress > 100:
		awardS4()
	elif starCounter == 5 && Global.fifthWaveProgress > 100:
		awardS5()
	elif starCounter == 6 && outline_star_particle_6.visible && Global.sixthWaveProgress > 100:
		awardS6()
	elif starCounter == 7 && outline_star_particle_7.visible && Global.seventhWaveProgress > 100:
		awardS7()
	elif starCounter >= 8:
		starCounter = -1
		star_award.stop()
