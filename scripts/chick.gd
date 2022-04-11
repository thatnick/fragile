extends Node2D

var speed = 100

func _process(delta):
	var velocity = Vector2(0, -1) * speed
	position += velocity * delta
	
	# TODO queue free when left the screen


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
