class_name Egg
extends RigidBody2D

const CHICK = preload("res://scenes/chick.tscn")
const LIVES_LOST_VALUE: int = 1
const SCORE_VALUE: int = 1
const HATCH_WAIT_TIME = 15
const NEST_HATCH_WAIT_TIME = 3

var in_nest = false setget set_in_nest
var hatched = false
var splatted = false
var clamp_velocity = 500.0

onready var hatch_sfx = preload("res://sfx/hatch.wav")
onready var splat_sfx = preload("res://sfx/splat.wav")

onready var previous_hatch_wait_time = $HatchTimer.wait_time
onready var manager = get_node("/root/Manager")
onready var game_scene = get_parent()

func _ready():
	# DEBUG set debug options
	if manager.egg_spin_on_start:
		# add a random rotation
		add_torque(manager.rng.randf_range(-50.0, 50.0))
	gravity_scale = manager.gravity
	linear_damp = manager.vel_damp
	angular_damp = manager.rot_vel_damp
	clamp_velocity = manager.clamp_egg_velocity
	
	$HatchTimer.start(HATCH_WAIT_TIME)

func _process(delta):
	if !hatched && !splatted:
		# change the hatching animation based on how long is left on timer
		var hatch_progress = $HatchTimer.time_left / $HatchTimer.wait_time
		if hatch_progress <= 0.25:
			$AnimatedSprite.animation = "v_cracked"
		elif hatch_progress <= 0.5:
			$AnimatedSprite.animation = "cracked"
			

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	if velocity.length() > clamp_velocity:
		state.set_linear_velocity(velocity.clamped(clamp_velocity))


func _on_Egg_body_entered(body):
	if body.name == "Floor" && !hatched:
		hit_floor()

# hatch the egg when the timer runs out
func _on_HatchTimer_timeout():
	hatch()

func disable_collide():
	$EggShapeTop.set_deferred("disabled", true)
	$EggShapeBottom.set_deferred("disabled", true)

func hit_floor():
	splatted = true
	$HatchTimer.stop()
	$AnimatedSprite.animation = "splat"
	$Sfx.set_stream(splat_sfx)
	$Sfx.play()
	disable_collide()
	make_static()
	manager.lives -= LIVES_LOST_VALUE
	
func hatch():
	hatched = true
	manager.score += SCORE_VALUE
	$AnimatedSprite.animation = "hatched"
	$Sfx.set_stream(hatch_sfx)
	$Sfx.play()
	spawn_chick()
	# stop chick from moving if it hatched in the nest
	if in_nest:
		make_static()
		disable_collide()
	# but if egg hatches in mid air, disable collisions and let it fall to floor
	# TODO reenable collisions but use layers so the shell hits the floor but
	# not the paddle or anything else
	else: 
		disable_collide()

func make_static():
	set_deferred("mode", MODE_STATIC)

func spawn_chick():
	var chick = CHICK.instance()
	chick.position = position
	game_scene.add_child(chick)

# this is set from the Nest scene
func set_in_nest(new_value):
	in_nest = new_value
	# speed up the hatch time if the egg is in the nest
	if in_nest && !hatched && $HatchTimer.time_left > NEST_HATCH_WAIT_TIME:
		# save the current time left, in case the egg bounces out of the nest
		previous_hatch_wait_time = $HatchTimer.time_left
		$HatchTimer.start(NEST_HATCH_WAIT_TIME)
	# the egg bounced out, set the timer back to what it was before the egg fell in the nest
	# TODO don't think this is working right
	elif !in_nest && !hatched:
		$HatchTimer.start(previous_hatch_wait_time)
