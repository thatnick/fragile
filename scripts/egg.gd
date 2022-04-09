#egg.gd

extends RigidBody2D



func _on_Egg_body_entered(body):
	if body.name == "Floor":
		set_mode(MODE_STATIC)
		print("mode was set to static")
		#change mode to static
	#if body entered == Nest AND !moving:
		#hatch/ score points
	pass 
