extends Node2D
@onready var upgrade_popup = $upgradePopup

func _process(_delta):
	if Global.popup_shouldbe_visible:
		upgrade_popup.visible = true
		upgrade_popup.tallyPoints()
