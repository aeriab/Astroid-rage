extends CanvasLayer

func _on_mutate_button_pressed():
	Global.mutateNumber += 1
	Global.evolutionPoints -= 1
