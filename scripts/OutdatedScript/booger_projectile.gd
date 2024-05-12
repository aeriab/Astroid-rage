extends CharacterBody2D

#func _ready():
	#move_and_slide()

func _physics_process(delta):
	
	if(get_slide_collision_count() != 0):
		queue_free()
		var collision = get_slide_collision(0)
		#print("Collided with: ", collision.get_collider().name)
		if collision.get_collider().name == "GoldCharBody":
			collision.get_collider().addDamage()
	else:
		move_and_slide()
