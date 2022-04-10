class_name Egg
extends RigidBody2D

const LIVES_LOST_VALUE: int = 1
const PLAYER_BOUNCE = 0.1
const SCORE_VALUE: int = 1
const HATCH_WAIT_TIME = 3

var in_nest = false setget set_in_nest
var hatched = false

onready var manager = get_node("/root/Manager")

func _ready():
	# DEBUG set debug options
	if manager.egg_spin_on_start:
		# add a random rotation
		add_torque(manager.rng.randf_range(-50.0, 50.0))
	gravity_scale = manager.gravity
	linear_damp = manager.vel_damp
	angular_damp = manager.rot_vel_damp
		
func _on_Egg_body_entered(body):
	if body.name == "Floor":
		hit_floor()

# hatch the egg when the timer runs out
func _on_HatchTimer_timeout():
	hatch()

func hit_floor():
	set_deferred("mode", MODE_STATIC)
	$EggShapeTop.set_deferred("disabled", true)
	$EggShapeBottom.set_deferred("disabled", true)
	manager.lives -= LIVES_LOST_VALUE
	#TODO change to the splat animation
	
func hatch():
	manager.score += SCORE_VALUE
	set_deferred("mode", MODE_STATIC)
	hatched = true
	
func set_in_nest(new_value):
	in_nest = new_value
	if in_nest && !hatched && $HatchTimer.is_stopped():
		$HatchTimer.start(HATCH_WAIT_TIME)
	elif !in_nest && !hatched:
		$HatchTimer.stop()
