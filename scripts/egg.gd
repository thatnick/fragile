#egg.gd

extends RigidBody2D

const PLAYER_BOUNCE = 0.1
var in_nest = false
var hatched = false
onready var manager = get_node("/root/Manager")

func _ready():
	# add a random rotation
	add_torque(manager.rng.randf_range(-50.0, 50.0))

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
	if body.name == "Player":
		# add an extra velocity boost when hitting the player
		apply_central_impulse(Vector2(cos(rotation), sin(rotation)) * PLAYER_BOUNCE)

# hatch the egg when the timer runs out (it starts on egg creation)
func _on_HatchTimer_timeout():
	hatch()
	# TODO play an animation instead of the egg just deleting it
	queue_free()

func hit_floor():
	set_deferred("mode", MODE_STATIC)
	$EggShapeTop.set_deferred("disabled", true)
	$EggShapeBottom.set_deferred("disabled", true)
	# TODO change to the splat animation
	
func hatch():
	print("An egg hatched!")
	hatched = true
	
	
	
