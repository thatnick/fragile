extends KinematicBody2D

const SPEED = 50

#TODO - make it so that the direction is randomly left or right on start up? Or can be predefined per instance of the object in a level?
var direction = Vector2(1, 0)

func _ready():
	if $Left:
		direction.x = -1

func _physics_process(delta):
	var collision = move_and_collide(direction * SPEED * delta)
	if collision:
		if collision.collider.get_class() == "Wall":
			#TODO - there must be a neater way of flipping the sign of direction.x?
			if direction.x == 1:
				direction.x = -1
			elif direction.x == -1:
				direction.x = 1
