extends Area2D

func _on_area_entered(area):
	
	if area.is_in_group("Gob"):
		#area.explodeGob()
		area.boundBounceBack()
	
	if area.is_in_group("Crasher"):
		area.boundBounceBack()
