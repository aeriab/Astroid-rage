extends Area2D


func _on_area_entered(area):
	if area.is_in_group("BoogerArea") && !area.is_in_group("Lazer"):
		area.free()
