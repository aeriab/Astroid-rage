extends RigidBody2D

func _ready():
	contact_monitor = true
	max_contacts_reported = 2

func _on_body_entered(body):
	print(body.name)
	call_deferred("queue_free")
	#print("Collided with: ", collision.get_collider().name)
	if body.name == "GoldyArea":
		body.addDamage()
