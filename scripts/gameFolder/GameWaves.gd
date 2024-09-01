extends Node

const RED_ENEMY = preload("res://scenes/enemy_scenes/redEnemy.tscn")
const PURPLE_ENEMY = preload("res://scenes/enemy_scenes/purple_worm.tscn")
const SWIRL_ENEMY = preload("res://scenes/enemy_scenes/swirl_enemy.tscn")
const ZAG_ENEMY = preload("res://scenes/enemy_scenes/zag_enemy.tscn")
const STAR_ENEMY = preload("res://scenes/enemy_scenes/star_enemy.tscn")

@onready var wave_timer_1 = $WaveTimer1
@onready var wave_timer_2 = $WaveTimer2
@onready var wave_timer_3 = $WaveTimer3
@onready var wave_timer_4 = $WaveTimer4
@onready var wave_timer_5 = $WaveTimer5
@onready var wave_timer_6 = $WaveTimer6
@onready var wave_timer_7 = $WaveTimer7

var difficulty: float = 1.0

var randomEnNum: int


var starEn1 = STAR_ENEMY.instantiate()
var starEn2 = STAR_ENEMY.instantiate()
var starEn3 = STAR_ENEMY.instantiate()
var starEn4 = STAR_ENEMY.instantiate()
var starEn5 = STAR_ENEMY.instantiate()
var starEn6 = STAR_ENEMY.instantiate()
var starEn7 = STAR_ENEMY.instantiate()

var onWave: int = 0


func _ready():
	wave_timer_1.wait_time = Global.wave1Wait
	wave_timer_2.wait_time = Global.wave2Wait
	wave_timer_3.wait_time = Global.wave3Wait
	wave_timer_4.wait_time = Global.wave4Wait
	wave_timer_5.wait_time = Global.wave5Wait
	wave_timer_6.wait_time = Global.wave6Wait
	wave_timer_7.wait_time = Global.wave7Wait
	
	wave_timer_1.start()



func _process(_delta):
	if onWave == 0 || onWave == 1:
		Global.firstWaveProgress = 100 - ((wave_timer_1.time_left / Global.wave1Wait) * 100)
	elif onWave == 2:
		Global.secondWaveProgress = 100 - ((wave_timer_2.time_left / Global.wave2Wait) * 100)
	elif onWave == 3:
		Global.thirdWaveProgress = 100 - ((wave_timer_3.time_left / Global.wave3Wait) * 100)
	elif onWave == 4:
		Global.fourthWaveProgress = 100 - ((wave_timer_4.time_left / Global.wave4Wait) * 100)
	elif onWave == 5:
		Global.fifthWaveProgress = 100 - ((wave_timer_5.time_left / Global.wave5Wait) * 100)
	elif onWave == 6:
		Global.sixthWaveProgress = 100 - ((wave_timer_6.time_left / Global.wave6Wait) * 100)
	elif onWave == 7:
		Global.seventhWaveProgress = 100 - ((wave_timer_7.time_left / Global.wave7Wait) * 100)
	
	if starEn1 == null && onWave == 1:
		Global.firstWaveProgress = 101
		onWave = 2
		wave_timer_2.start()
	if starEn2 == null && onWave == 2:
		Global.secondWaveProgress = 101
		onWave = 3
		wave_timer_3.start()
	if starEn3 == null && onWave == 3:
		Global.thirdWaveProgress = 101
		onWave = 4
		wave_timer_4.start()
	if starEn4 == null && onWave == 4:
		Global.fourthWaveProgress = 101
		onWave = 5
		wave_timer_5.start()
	if starEn5 == null && onWave == 5:
		Global.fifthWaveProgress = 101
		onWave = 6
		wave_timer_6.start()
	if starEn6 == null && onWave == 6:
		Global.sixthWaveProgress = 101
		onWave = 7
		wave_timer_7.start()
	
	if starEn7 == null && onWave == 7:
		Global.seventhWaveProgress = 101
		onWave = 8



var innerBoundX = 2000
var innerBoundY = 2000
var outerBoundX = 3000
var outerBoundY = 3000

var globRadius: float = 0

var x: float = 0
var y: float = 0

var flipSprite: float = 0

func spawnRedEnemy():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	var enemy = RED_ENEMY.instantiate()
	enemy.spawn(randf_range(0.8,1.6) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

func spawnPurpleEnemy():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	var enemy = PURPLE_ENEMY.instantiate()
	enemy.spawn(randf_range(1.0,2.0) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

func spawnSwirlEnemy():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	var enemy = SWIRL_ENEMY.instantiate()
	enemy.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

func spawnZagEnemy():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	var enemy = ZAG_ENEMY.instantiate()
	enemy.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)

func spawnStarEnemy():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	var enemy = STAR_ENEMY.instantiate()
	enemy.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(enemy)








func _on_wave_timer_1_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn1.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn1)
	onWave = 1


func _on_wave_timer_2_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn2.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn2)


func _on_wave_timer_3_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn3.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn3)


func _on_wave_timer_4_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn4.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn4)


func _on_wave_timer_5_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn5.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn5)


func _on_wave_timer_6_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn6.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn6)


func _on_wave_timer_7_timeout():
	x = randf_range(0,outerBoundX)
	if x < innerBoundX:
		y = randf_range(innerBoundY,outerBoundY)
	else:
		y = randf_range(0,outerBoundY)
	if randi_range(0,1) == 1:
		x = -x
		flipSprite = 1
	else:
		flipSprite = -1
	if randi_range(0,1) == 1:
		y = -y
	
	starEn7.spawn(randf_range(0.5,1.5) * difficulty,x,y,flipSprite)
	get_parent().add_child.call_deferred(starEn7)






