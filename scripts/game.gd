extends Node2D
@onready var upgrade_popup = $upgradePopup
@onready var evo_selection = $evo_selection
@onready var pause_menu = $PauseMenu

var firstEvoOn: bool = true
var firstEvoOff: bool = true

var firstStoreOn: bool = true
var firstStoreOff: bool = true

func _process(_delta):
	if Global.popup_shouldbe_visible && firstStoreOn:
		upgrade_popup.visible = true
		upgrade_popup.tallyPoints()
		upgrade_popup.storeSelectStart()
		firstStoreOn = false
		firstStoreOff = true
	if !Global.popup_shouldbe_visible && firstStoreOff:
		upgrade_popup.storeSelectFinish()
		firstStoreOff = false
		firstStoreOn = true
	
	if Global.evolutionPoints > 0 && firstEvoOn:
		evo_selection.visible = true
		evo_selection.evoSelectStart()
		firstEvoOn = false
		firstEvoOff = true
	if Global.evolutionPoints <= 0 && firstEvoOff:
		evo_selection.visible = false
		evo_selection.evoSelectFinish()
		firstEvoOff = false
		firstEvoOn = true
	
	if upgrade_popup.visible == true:
		upgrade_popup.tallyPoints()
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = true
		Engine.time_scale = 0.0
