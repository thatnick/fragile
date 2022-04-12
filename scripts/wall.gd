extends StaticBody2D

#Rewrote get_class to return custom value so that KinematicCollision2D.collider.get_class() can be used to test if the collision was with a wall.
func get_class():
	return "Wall"

