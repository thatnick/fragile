class_name Egg
extends RigidBody2D

const LIVES_LOST_VALUE: int = 1
const SCORE_VALUE: int = 1
const HATCH_WAIT_TIME = 15
const NEST_HATCH_WAIT_TIME = 3

var in_nest = false setget set_in_nest
var hatched = false
var splatted = false

onready var previous_hatch_wait_time = $HatchTimer.wait_time
onready var manager = get_node("/root/Manager")

func _ready():
	# DEBUG set debug options
	if manager.egg_spin_on_start:
		# add a random rotation
		add_torque(manager.rng.randf_range(-50.0, 50.0))
	gravity_scale = manager.gravity
	linear_damp = manager.vel_damp
	angular_damp = manager.rot_vel_damp
	
	$HatchTimer.start(HATCH_WAIT_TIME)

func _process(delta):
	if !hatched && !splatted:
		# change the hatching animation based on how long is left on timer
		var hatch_progress = $HatchTimer.time_left / $HatchTimer.wait_time
		if hatch_progress <= 0.25:
			$AnimatedSprite.animation = "v_cracked"
		elif hatch_progress <= 0.5:
			$AnimatedSprite.animation = "cracked"
		
func _on_Egg_body_entered(body):
	if body.name == "Floor":
		hit_floor()

# hatch the egg when the timer runs out
func _on_HatchTimer_timeout():
	hatch()

func hit_floor():
	splatted = true
	$HatchTimer.stop()
	$AnimatedSprite.animation = "splat"
	set_deferred("mode", MODE_STATIC)
	$EggShapeTop.set_deferred("disabled", true)
	$EggShapeBottom.set_deferred("disabled", true)
	manager.lives -= LIVES_LOST_VALUE
	
func hatch():
	hatched = true
	manager.score += SCORE_VALUE
	$AnimatedSprite.animation = "chick"
	# stop chick from moving
	set_deferred("mode", MODE_STATIC)
	# if egg hatches in mid air, disable collisions
	if !in_nest:
		$EggShapeTop.set_deferred("disabled", true)
		$EggShapeBottom.set_deferred("disabled", true)

# this is set from the Nest scene
func set_in_nest(new_value):
	in_nest = new_value
	# speed up the hatch time if the egg is in the nest
	if in_nest && !hatched && $HatchTimer.time_left > NEST_HATCH_WAIT_TIME:
		# save the current time left, in case the egg bounces out of the nest
		previous_hatch_wait_time = $HatchTimer.time_left
		$HatchTimer.start(NEST_HATCH_WAIT_TIME)
	# the egg bounced out, set the timer back to what it was before the egg fell in the nest
	elif !in_nest && !hatched:
		$HatchTimer.start(previous_hatch_wait_time)
