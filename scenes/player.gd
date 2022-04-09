extends KinematicBody2D

const SPEED = 25000
var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	velocity = velocity.normalized() * SPEED
	pass

func _physics_process(delta):
	get_input()
	move_and_slide(velocity * delta)
	pass # Replace with function body.

