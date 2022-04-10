extends Node2D

var speed = 100

func _process(delta):
	var velocity = Vector2(0, -1) * speed
	position += velocity * delta
	
	# TODO queue free when left the screen
