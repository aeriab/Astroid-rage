extends Node

const RED_ENEMY = preload("res://scenes/enemy_scenes/redEnemy.tscn")
const PURPLE_ENEMY = preload("res://scenes/enemy_scenes/purple_worm.tscn")
const SWIRL_ENEMY = preload("res://scenes/enemy_scenes/swirl_enemy.tscn")
const ZAG_ENEMY = preload("res://scenes/enemy_scenes/zag_enemy.tscn")
const STAR_ENEMY = preload("res://scenes/enemy_scenes/star_enemy.tscn")
const BULK_ENEMY = preload("res://scenes/enemy_scenes/bulk_enemy.tscn")
const BOSS_ENEMY = preload("res://scenes/enemy_scenes/boss_enemy.tscn")
const COUNTER_ENEMY = preload("res://scenes/enemy_scenes/counter_enemy.tscn")

const AXOL_ENEMY = preload("res://scenes/enemy_scenes/axolotl_enemy.tscn")

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

var wave_time_1: float = 0.0
var wave_time_2: float = 0.0
var wave_time_3: float = 0.0
var wave_time_4: float = 0.0
var wave_time_5: float = 0.0
var wave_time_6: float = 0.0
var wave_time_7: float = 0.0


var stage1EnArray = []

@onready var final_level_stuff = $"../FinalLevelStuff"
@onready var axolotl = $"../FinalLevelStuff/Axolotl"

func _ready():
	
	if Global.current_stage != "Massive Marsh":
		final_level_stuff.queue_free()
	
	
	if Global.current_stage == "Tutorial Tidepool":
		axol_timer.stop()
	
	if Global.waveNum == 7:
		onWave = 1
	elif Global.waveNum == 5:
		onWave = 2
	elif Global.waveNum == 3:
		onWave = 3

var firstW1: bool = true
var firstW2: bool = true
var firstW3: bool = true
var firstW4: bool = true
var firstW5: bool = true
var firstW6: bool = true
var firstW7: bool = true

var firstSp1: bool = true
var firstSp2: bool = true
var firstSp3: bool = true
var firstSp4: bool = true
var firstSp5: bool = true
var firstSp6: bool = true
var firstSp7: bool = true

var waveFinishedCreating: bool = false
@onready var health_bar_red = $"../HealthBarRed"

func _process(delta):
	
	if Global.current_stage == "Tutorial Tidepool":
		Global.player_health += delta * Global.gameTimeScale * 10
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalMultiSpawn(1,"empty",0.1,true,0.1)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalMultiSpawn(3,"axol",1,true,10)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(40,"red",2,false,5)
			generalMultiSpawn2(3,"axol",1,true)
	
	if Global.current_stage == "Learner Lagoon":
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalMultiSpawn(10,"red",0.5,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalMultiSpawn(5,"swirl",3,true,10)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(30,"red",0.8,false,10)
			generalMultiSpawn2(10,"swirl",3,true)
	
	if Global.current_stage == "Perfect Pond":
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(15,"purple")
			generalMultiSpawn(5,"zag",0.5,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(10,"swirl")
			generalMultiSpawn(10,"red",2,true,10)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(10,"purple",1.5,false,10)
			generalPerfSpawn(20,"zag")
			generalMultiSpawn2(2,"bulk",5,true)
	
	if Global.current_stage == "Giga Geyser":
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(1,"boss",5,true,10)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(35,"purple")
			generalMultiSpawn(10,"zag",1.5,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(10,"swirl")
			generalMultiSpawn(10,"red",1.5,false,10)
			generalMultiSpawn2(3,"boss",5,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(10,"zag",1.5,true,10)
			generalPerfSpawn(8,"bulk")
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(5,"boss")
			generalMultiSpawn(10,"swirl",1.5,true,10)
	
	if Global.current_stage == "Swirly Swamp":
		if onWave == 1 && firstSp1:
			firstSp1 = false
			generalMultiSpawn(1,"counter",5,true,10)
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(20,"red",1.5,false,10)
			generalMultiSpawn2(3,"boss",5,true)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(1,"counter")
			generalMultiSpawn(10,"zag",1.5,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(3,"bulk")
			generalMultiSpawn(3,"boss",5,true,10)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(35,"zag",0.5,true,10)
			generalPerfSpawn(1,"boss")
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(2,"counter")
			generalMultiSpawn(20,"swirl",0.5,true,10)
		if onWave == 7 && firstSp7:
			firstSp7 = false
			generalMultiSpawn(100,"red",0.2,true,10)
			generalPerfSpawn(6,"boss")
	
	if Global.current_stage == "Offset Ocean":
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(1,"zag",5,true,5)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(40,"purple")
			generalMultiSpawn(50,"purple",0.6,false,10)
			generalMultiSpawn2(75,"purple",0.4,true)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(10,"zag")
			generalMultiSpawn(100,"red",0.2,false,10)
			generalMultiSpawn2(3,"boss",5,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(80,"zag",0.6,true,10)
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(80,"purple")
			generalMultiSpawn(50,"zag",0.4,false,10)
			generalMultiSpawn2(100,"purple",0.25,true)
	
	if Global.current_stage == "Serpent Sea":
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(30,"swirl")
			generalMultiSpawn(30,"zag",0.6,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(5,"swirl")
			generalMultiSpawn(5,"boss",0.2,false,10)
			generalMultiSpawn2(20,"swirl",0.1,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalPerfSpawn(60,"zag")
			generalMultiSpawn(60,"swirl",0.3,true,10)
	
	if Global.current_stage == "Baffle Bay":
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(2,"counter")
			generalMultiSpawn(20,"bulk",0.6,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(5,"boss")
			generalMultiSpawn(100,"red",0.2,false,10)
			generalMultiSpawn2(20,"boss",0.5,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalPerfSpawn(3,"counter")
			generalMultiSpawn(150,"red",0.2,false,10)
			generalMultiSpawn2(10,"boss",0.5,true)
	
	if Global.current_stage == "Conic Cove":
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(5,"swirl",2,true,5)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(5,"counter")
			generalMultiSpawn(5,"swirl",2,false,10)
			generalMultiSpawn2(20,"bulk",0.4,true)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(10,"red")
			generalMultiSpawn(100,"zag",0.2,false,10)
			generalMultiSpawn2(3,"boss",5,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(80,"swirl",0.6,true,10)
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(10,"counter")
			generalMultiSpawn(50,"swirl",0.5,false,10)
			generalMultiSpawn2(60,"bulk",0.2,true)
	
	if Global.current_stage == "Steamy Stream":
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalMultiSpawn(40,"boss",0.3,true,10)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(400,"red")
			generalMultiSpawn(10,"boss",0.6,true,10)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(100,"purple")
			generalMultiSpawn(100,"zag",0.2,false,10)
			generalMultiSpawn2(100,"swirl",0.2,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn(15,"counter",0.6,true,10)
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(50,"boss")
			generalMultiSpawn(300,"red",0.3,true,10)
	
	if Global.current_stage == "Massive Marsh":
		if onWave == 1 && firstSp1:
			firstSp1 = false
			generalPerfSpawn(100,"red")
			generalMultiSpawn(100,"zag",0.2,false,10)
			generalMultiSpawn2(100,"swirl",0.2,true)
		if onWave == 2 && firstSp2:
			firstSp2 = false
			generalPerfSpawn(20,"bulk")
			generalMultiSpawn(100,"zag",0.2,false,10)
			generalMultiSpawn2(100,"swirl",0.2,true)
		if onWave == 3 && firstSp3:
			firstSp3 = false
			generalPerfSpawn(15,"boss")
			generalMultiSpawn(100,"purple",0.1,false,10)
			generalMultiSpawn2(100,"red",0.1,true)
		if onWave == 4 && firstSp4:
			firstSp4 = false
			generalPerfSpawn(100,"zag")
			generalMultiSpawn(200,"red",0.2,false,10)
			generalMultiSpawn2(100,"swirl",0.2,true)
		if onWave == 5 && firstSp5:
			firstSp5 = false
			generalMultiSpawn2(20,"red",0.05,true)
		if onWave == 6 && firstSp6:
			firstSp6 = false
			generalPerfSpawn(100,"purple")
			generalMultiSpawn(5,"counter",0.3,false,10)
			generalMultiSpawn2(20,"counter",0.05,true)
		if onWave == 7 && firstSp7:
			firstSp7 = false
			generalPerfSpawn(100,"boss")
			generalMultiSpawn(200,"zag",0.1,false,10)
			generalMultiSpawn2(200,"swirl",0.1,true)
	
	
	
	
	
	
	if waveFinishedCreating:
		endWaveWait -= delta * Global.gameTimeScale
	
	if starEn1 == null:
		if onWave == 1:
			Global.firstWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 2
	elif !starEn1.isAlive:
		if onWave == 1:
			Global.firstWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 2
	
	if starEn2 == null:
		if onWave == 2:
			Global.secondWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 3
	elif !starEn2.isAlive:
		if onWave == 2:
			Global.secondWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 3
	
	if starEn3 == null:
		if onWave == 3:
			Global.thirdWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 4
	elif !starEn3.isAlive:
		if onWave == 3:
			Global.thirdWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 4
	
	if starEn4 == null:
		if onWave == 4:
			Global.fourthWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 5
	elif !starEn4.isAlive:
		if onWave == 4:
			Global.fourthWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 5
	
	if starEn5 == null:
		if onWave == 5:
			Global.fifthWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 6
	elif !starEn5.isAlive:
		if onWave == 5:
			Global.fifthWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 6
	
	if starEn6 == null:
		if onWave == 6:
			Global.sixthWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 7
	elif !starEn6.isAlive:
		if onWave == 6:
			Global.sixthWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 7
	
	if starEn7 == null:
		if onWave == 7:
			Global.seventhWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 8
	elif !starEn7.isAlive:
		if onWave == 7:
			Global.seventhWaveProgress = 101
			if endWaveWait <= 0:
				onWave = 8



var innerBoundX = 2000
var innerBoundY = 2000
var outerBoundX = 3000
var outerBoundY = 3000

var globRadius: float = 0

var x: float = 0
var y: float = 0

var flipSprite: float = 0

var theta: float = 0.0
var radius: float = 4000
@onready var next_en_timer = $NextEnTimer
var nextEnAmount = 0
var genEnemy = "red"
var nextEnAmount2 = 0
var genEnemy2 = "red"

var waveEndHere: bool = false
var endWaveWait: float = 5.0
var waveEndHere2: bool = false

func _on_next_en_timer_timeout():
	if genEnemy == "red":
		spawnRedEnemy()
	elif genEnemy == "bulk":
		spawnBulkEnemy()
	elif genEnemy == "purple":
		spawnPurpleEnemy()
	elif genEnemy == "swirl":
		spawnSwirlEnemy()
	elif genEnemy == "zag":
		spawnZagEnemy()
	elif genEnemy == "boss":
		spawnBossEnemy()
	elif genEnemy == "counter":
		spawnCounterEnemy()
	elif genEnemy == "axol":
		spawnAxolEnemy()
	
	if nextEnAmount >= 1:
		if nextEnAmount == 1 && waveEndHere:
			waveFinishedCreating = true
			spawnStarEnemy()
		nextEnAmount -= 1
	else:
		next_en_timer.stop()

func generalMultiSpawn(amount,enemy,delay,isWaveEnd,timeNextWave):
	waveFinishedCreating = false
	next_en_timer.wait_time = delay
	nextEnAmount = amount
	genEnemy = enemy
	next_en_timer.start()
	waveEndHere = isWaveEnd
	endWaveWait = timeNextWave

@onready var next_en_timer_2 = $NextEnTimer2

func _on_next_en_timer_2_timeout():
	if genEnemy2 == "red":
		spawnRedEnemy()
	elif genEnemy2 == "bulk":
		spawnBulkEnemy()
	elif genEnemy2 == "purple":
		spawnPurpleEnemy()
	elif genEnemy2 == "swirl":
		spawnSwirlEnemy()
	elif genEnemy2 == "zag":
		spawnZagEnemy()
	elif genEnemy2 == "boss":
		spawnBossEnemy()
	elif genEnemy2 == "counter":
		spawnCounterEnemy()
	elif genEnemy2 == "axol":
		spawnAxolEnemy()
	
	if nextEnAmount2 >= 1:
		if nextEnAmount2 == 1 && waveEndHere2:
			waveFinishedCreating = true
			spawnStarEnemy()
		nextEnAmount2 -= 1
	else:
		next_en_timer_2.stop()

func generalMultiSpawn2(amount,enemy,delay,isWaveEnd):
	next_en_timer_2.wait_time = delay
	nextEnAmount2 = amount
	genEnemy2 = enemy
	next_en_timer_2.start()
	waveEndHere2 = isWaveEnd


func generalPerfSpawn(amount,enemy):
	var i = 0
	while i < amount:
		theta = ((2*PI)/amount) * i
		if theta >= PI/2 && theta <= 3 * PI / 2:
			flipSprite = 1
		else:
			flipSprite = -1
		
		if enemy == "red":
			var red = RED_ENEMY.instantiate()
			red.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(red)
		elif enemy == "bulk":
			var bulk = BULK_ENEMY.instantiate()
			bulk.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(bulk)
		elif enemy == "purple":
			var purple = PURPLE_ENEMY.instantiate()
			purple.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(purple)
		elif enemy == "swirl":
			var swirl = SWIRL_ENEMY.instantiate()
			swirl.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(swirl)
		elif enemy == "zag":
			var zag = ZAG_ENEMY.instantiate()
			zag.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(zag)
		elif enemy == "boss":
			var boss = BOSS_ENEMY.instantiate()
			boss.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(boss)
		elif enemy == "counter":
			var counter = COUNTER_ENEMY.instantiate()
			counter.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(counter)
		elif enemy == "axol":
			var axol = AXOL_ENEMY.instantiate()
			axol.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
			get_parent().add_child.call_deferred(axol)
		
		i += 1



func spawnGeneral(enemy):
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	enemy.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
	get_parent().add_child.call_deferred(enemy)





func spawnRedEnemy():
	var enemy = RED_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnPurpleEnemy():
	var enemy = PURPLE_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnSwirlEnemy():
	var enemy = SWIRL_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnZagEnemy():
	var enemy = ZAG_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnBulkEnemy():
	var enemy = BULK_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnBossEnemy():
	var enemy = BOSS_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnCounterEnemy():
	var enemy = COUNTER_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnAxolEnemy():
	var enemy = AXOL_ENEMY.instantiate()
	spawnGeneral(enemy)

func spawnStarEnemy():
	theta = randf_range(0.0, 6.283)
	if theta >= PI/2 && theta <= 3 * PI / 2:
		flipSprite = 1
	else:
		flipSprite = -1
	if onWave == 1:
		starEn1.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn1)
	if onWave == 2:
		starEn2.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn2)
	if onWave == 3:
		starEn3.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn3)
	if onWave == 4:
		starEn4.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn4)
	if onWave == 5:
		starEn5.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn5)
	if onWave == 6:
		starEn6.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn6)
	if onWave == 7:
		starEn7.spawn(1.0,radius * cos(theta),radius * sin(theta),flipSprite)
		get_parent().add_child.call_deferred(starEn7)

@onready var axol_timer = $AxolTimer

func _on_axol_timer_timeout():
	var axol_wave_fate: int = 0
	axol_wave_fate = randf_range(1,100)
	if axol_wave_fate < 65:
		spawnAxolEnemy()
	elif axol_wave_fate < 90:
		spawnAxolEnemy()
		spawnAxolEnemy()
	elif axol_wave_fate < 99:
		spawnAxolEnemy()
		spawnAxolEnemy()
		spawnAxolEnemy()
	else:
		spawnAxolEnemy()
		spawnAxolEnemy()
		spawnAxolEnemy()
		spawnAxolEnemy()
		spawnAxolEnemy()
	
	axol_timer.wait_time = randf_range(5.0,7.0)
	axol_timer.start()
	
