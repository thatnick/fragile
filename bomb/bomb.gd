class_name Bomb
extends KinematicBody2D

var is_moving = true
var gravity_vector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2()

func _ready():
	velocity = gravity_vector * gravity_magnitude

func _physics_process(delta):
	if is_moving:
		var collision = move_and_collide(velocity * delta)
		if collision:
			if collision.collider is Floor:
				hit_floor()
			else:
				velocity = velocity.bounce(collision.normal)
		pass
	
func hit_floor():
	print("bomb hit floor")
	is_moving = false
	pass
