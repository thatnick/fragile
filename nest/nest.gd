extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body is Egg:
		body.in_nest = true

func _on_Area2D_body_exited(body):
	if body is Egg:
		body.in_nest = false
