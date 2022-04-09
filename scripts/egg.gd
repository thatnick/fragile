#egg.gd

extends RigidBody2D

var in_nest = false
var hatched = false

func _process(delta):
	# hatch the egg immediately if it has stopped moving inside the nest
	if in_nest && !hatched && sleeping:
		$HatchTimer.stop()
		hatch()
		
func _on_Egg_body_entered(body):
	if body.name == "Floor":
		hit_floor()

# hatch the egg when the timer runs out (it starts on egg creation)
func _on_HatchTimer_timeout():
	hatch()

func hit_floor():
	# stop the egg from moving, must be set after current frames physics step
	set_deferred("mode", MODE_STATIC)
	# TODO change to the splat animation
	
func hatch():
	print("An egg hatched!")
	hatched = true
	
	# Might only want to do this in the nest, not in mid-air
	# but leave for testing as makes clear an egg has hatched
	set_deferred("mode", MODE_STATIC)
	
