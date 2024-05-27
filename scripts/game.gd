extends Node2D
@onready var upgrade_popup = $upgradePopup
@onready var evo_selection = $evo_selection

func _process(_delta):
	if Global.popup_shouldbe_visible:
		upgrade_popup.visible = true
		upgrade_popup.tallyPoints()
	
	if Global.evolutionPoints > 0:
		evo_selection.visible = true
	else:
		evo_selection.visible = false
