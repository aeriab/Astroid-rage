extends StaticBody2D


var clockwise = 1
var SPEED = Global.rotationSpeed

func _physics_process(delta):
	if Input.is_action_just_pressed("switch"):
		clockwise *= -1
	
	rotation += (SPEED * clockwise * delta)

func _on_body_entered(body):
	if body.name == "GoldCharBody":
		print("ending game")
		Global.endGame()
