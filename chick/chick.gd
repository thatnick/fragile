extends Node2D

const SPEED = 100

func _process(delta):
	var velocity = Vector2(0, -1) * SPEED
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
