#egg.gd

extends RigidBody2D

const LIVES_LOST_VALUE: int = 1
const PLAYER_BOUNCE = 0.1
const SCORE_VALUE: int = 10

var in_nest = false
var hatched = false

onready var manager = get_node("/root/Manager")

func _ready():
	# add a random rotation
	add_torque(manager.rng.randf_range(-50.0, 50.0))
	
	# DEBUG Set options from the debug screen
	gravity_scale = manager.gravity
	linear_damp = manager.vel_damp
	angular_damp = manager.rot_vel_damp

func _process(delta):
	# hatch the egg immediately if it has stopped moving inside the nest
	if in_nest && !hatched && sleeping:
		$HatchTimer.stop()
		# stop the egg from moving, must be set after current frames physics step
		set_deferred("mode", MODE_STATIC)
		hatch()
		
func _on_Egg_body_entered(body):
	if body.name == "Floor":
		hit_floor()

# hatch the egg when the timer runs out (it starts on egg creation)
func _on_HatchTimer_timeout():
	# GAMEPLAY TESTING: Turned off eggs hatching in mid air
	pass
	#hatch()
	# TODO play an animation instead of just deleting the egg
	#queue_free()

func hit_floor():
	set_deferred("mode", MODE_STATIC)
	$EggShapeTop.set_deferred("disabled", true)
	$EggShapeBottom.set_deferred("disabled", true)
	manager.lives -= LIVES_LOST_VALUE
	#TODO change to the splat animation
	
func hatch():
	manager.score += SCORE_VALUE
	hatched = true
	
	
	
