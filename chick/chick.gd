class_name Chick
extends RigidBody2D

const SPEED = 100

func _ready():
	apply_central_impulse(Vector2(0, -1) * SPEED)

func explosion_impulse(explosion_vector: Vector2, explosion_force: int):
	apply_central_impulse(explosion_vector * explosion_force)
