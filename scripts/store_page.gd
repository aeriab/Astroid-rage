extends CanvasLayer

@onready var unspent_points = $UnspentPoints

#@onready var color_rect_2 = $bulletSize/ColorRect2
#@onready var color_rect_3 = $bulletSize/ColorRect3
#@onready var color_rect_4 = $bulletSize/ColorRect4
#@onready var color_rect_5 = $bulletSize/ColorRect5
#@onready var color_rect_6 = $bulletSize/ColorRect6
#@onready var color_rect_7 = $bulletSize/ColorRect7
#@onready var color_rect_8 = $bulletSize/ColorRect8
#@onready var color_rect_9 = $bulletSize/ColorRect9
#@onready var color_rect_10 = $bulletSize/ColorRect10
#@onready var color_rect_11 = $bulletSize/ColorRect11
#@onready var color_rect_12 = $bulletSize/ColorRect12
#@onready var color_rect_13 = $bulletSize/ColorRect13
#@onready var color_rect_14 = $bulletSize/ColorRect14
#@onready var color_rect_15 = $bulletSize/ColorRect15

var bulVisArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var bulSpVisArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var damVisArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var rotVisArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
@onready var bulRectArray = [$bulletSize/ColorRect2,$bulletSize/ColorRect3,$bulletSize/ColorRect4,$bulletSize/ColorRect5,$bulletSize/ColorRect6,$bulletSize/ColorRect7,$bulletSize/ColorRect8,$bulletSize/ColorRect9,$bulletSize/ColorRect10,$bulletSize/ColorRect11,$bulletSize/ColorRect12,$bulletSize/ColorRect13,$bulletSize/ColorRect14,$bulletSize/ColorRect15]
@onready var bulSpRectArray = [$bulletSpeed/ColorRect2,$bulletSpeed/ColorRect3,$bulletSpeed/ColorRect4,$bulletSpeed/ColorRect5,$bulletSpeed/ColorRect6,$bulletSpeed/ColorRect7,$bulletSpeed/ColorRect8,$bulletSpeed/ColorRect9,$bulletSpeed/ColorRect10,$bulletSpeed/ColorRect11,$bulletSpeed/ColorRect12,$bulletSpeed/ColorRect13,$bulletSpeed/ColorRect14,$bulletSpeed/ColorRect15]
@onready var damRectArray = [$damageUp/ColorRect2,$damageUp/ColorRect3,$damageUp/ColorRect4,$damageUp/ColorRect5,$damageUp/ColorRect6,$damageUp/ColorRect7,$damageUp/ColorRect8,$damageUp/ColorRect9,$damageUp/ColorRect10,$damageUp/ColorRect11,$damageUp/ColorRect12,$damageUp/ColorRect13,$damageUp/ColorRect14,$damageUp/ColorRect15]
@onready var rotRectArray = [$rotationSpeed/ColorRect2,$rotationSpeed/ColorRect3,$rotationSpeed/ColorRect4,$rotationSpeed/ColorRect5,$rotationSpeed/ColorRect6,$rotationSpeed/ColorRect7,$rotationSpeed/ColorRect8,$rotationSpeed/ColorRect9,$rotationSpeed/ColorRect10,$rotationSpeed/ColorRect11,$rotationSpeed/ColorRect12,$rotationSpeed/ColorRect13,$rotationSpeed/ColorRect14,$rotationSpeed/ColorRect15]

func _ready():
	tallyPoints()
	
	tallyBulSize()
	tallyBulSpeed()
	tallyDamage()
	tallyRotSpeed()


###########################################

func _on_bullet_size_pressed():
	incrBulSize()
func _on_add_size_pressed():
	incrBulSize()
func _on_minus_size_pressed():
	decrBulSize()

func _on_bullet_speed_pressed():
	incrBulSpeed()
func _on_add_speed_pressed():
	incrBulSpeed()
func _on_minus_speed_pressed():
	decrBulSpeed()

func _on_damage_up_pressed():
	incrDamage()
func _on_add_dam_pressed():
	incrDamage()
func _on_minus_dam_pressed():
	decrDamage()

func _on_rotation_speed_pressed():
	incrRotSpeed()
func _on_add_rot_pressed():
	incrRotSpeed()
func _on_minus_rot_pressed():
	decrRotSpeed()

###########################################

func incrBulSize():
	if Global.unspentPoints > 0 && Global.bulletSize < 16:
		Global.unspentPoints -= 1
		if Global.unspentPoints == 0:
			visible = false
			Global.popup_shouldbe_visible = false
		Global.bulletSize += 1
		tallyPoints()
		tallyBulSize()

func incrBulSpeed():
	if Global.unspentPoints > 0 && Global.bulletSpeed < 16:
		Global.unspentPoints -= 1
		if Global.unspentPoints == 0:
			visible = false
			Global.popup_shouldbe_visible = false
		Global.bulletSpeed += 1
		tallyPoints()
		tallyBulSpeed()

func incrDamage():
	if Global.unspentPoints > 0 && Global.damage < 18:
		Global.unspentPoints -= 1
		if Global.unspentPoints == 0:
			visible = false
			Global.popup_shouldbe_visible = false
		Global.damage += 1
		tallyPoints()
		tallyDamage()

func incrRotSpeed():
	if Global.unspentPoints > 0 && Global.rotationSpeed < 17:
		Global.unspentPoints -= 1
		if Global.unspentPoints == 0:
			visible = false
			Global.popup_shouldbe_visible = false
		Global.rotationSpeed += 1
		tallyPoints()
		tallyRotSpeed()

###########################################

func decrBulSize():
	if Global.bulletSize > 2:
		Global.unspentPoints += 1
		Global.bulletSize -= 1
		tallyPoints()
		tallyBulSize()

func decrBulSpeed():
	if Global.bulletSpeed > 2:
		Global.unspentPoints += 1
		Global.bulletSpeed -= 1
		tallyPoints()
		tallyBulSpeed()

func decrDamage():
	if Global.damage > 4:
		Global.unspentPoints += 1
		Global.damage -= 1
		tallyPoints()
		tallyDamage()

func decrRotSpeed():
	if Global.rotationSpeed > 3:
		Global.unspentPoints += 1
		Global.rotationSpeed -= 1
		tallyPoints()
		tallyRotSpeed()

###########################################

func tallyPoints():
	unspent_points.text = "Unspent points: " + str(Global.unspentPoints)

func tallyBulSize():
	var i = 0
	for bulSizeRect in bulVisArray:
		if (Global.bulletSize - 2) > i:
			bulVisArray[i] = 1
			bulRectArray[i].visible = true
		else:
			bulVisArray[i] = 0
			bulRectArray[i].visible = false
		i += 1

func tallyBulSpeed():
	var i = 0
	for bulSizeRect in bulSpVisArray:
		if (Global.bulletSpeed - 2) > i:
			bulSpVisArray[i] = 1
			bulSpRectArray[i].visible = true
		else:
			bulSpVisArray[i] = 0
			bulSpRectArray[i].visible = false
		i += 1

func tallyDamage():
	var i = 0
	for bulSizeRect in damVisArray:
		if (Global.damage - 4) > i:
			damVisArray[i] = 1
			damRectArray[i].visible = true
		else:
			damVisArray[i] = 0
			damRectArray[i].visible = false
		i += 1

func tallyRotSpeed():
	var i = 0
	for bulSizeRect in rotVisArray:
		if (Global.rotationSpeed - 3) > i:
			rotVisArray[i] = 1
			rotRectArray[i].visible = true
		else:
			rotVisArray[i] = 0
			rotRectArray[i].visible = false
		i += 1

###########################################

func _on_back_to_game_pressed():
	Engine.time_scale = 1.0
	Global.upgradePhase = false
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
