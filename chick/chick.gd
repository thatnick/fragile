extends RigidBody2D

const SPEED = 100

func _ready():
	apply_central_impulse(Vector2(0, -1) * SPEED)
