class_name Egg
extends RigidBody2D

const CHICK = preload("res://chick/chick.tscn")
const POP_UP_SCORE = preload("res://pop_up_score/pop_up_score.tscn")
const SCORE_VALUE: int = 10
const VELOCITY_CLAMP = 400

var hatched = false
var splatted = false
var clamp_velocity = 500.0

var choc_mode

onready var hatch_sfx = preload("res://egg/sfx/hatch_cheep_cheep.wav")
onready var splat_sfx = preload("res://egg/sfx/egg_splat.wav")

onready var manager = get_node("/root/Manager")
onready var game_scene = get_parent()

func _ready():
	choc_mode = manager.choc_mode
	if choc_mode:
		$AnimatedSprite.animation = "default_bunny"
	# add a random rotation
	add_torque(manager.rng.randf_range(-50.0, 50.0))		

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	if velocity.length() > VELOCITY_CLAMP:
		state.set_linear_velocity(velocity.clamped(VELOCITY_CLAMP))

func _on_Egg_body_entered(body):
	if body is Floor && !hatched:
		hit_floor()
	elif body is Nest:
		hatch()

func _on_DeleteShellTimer_timeout():
	queue_free()

func disable_collide():
	$EggShapeTop.set_deferred("disabled", true)
	$EggShapeBottom.set_deferred("disabled", true)

func hit_floor():
	splatted = true
	$AnimatedSprite.animation = "splat"
	$Sfx.set_stream(splat_sfx)
	$Sfx.play()
	disable_collide()
	make_static()
	rotation_degrees = 0
	
func hatch():
	hatched = true
	score()
	if !choc_mode:
		$AnimatedSprite.animation = "hatched"
	else:
		$AnimatedSprite.animation = "hatched_bunny"
	$Sfx.set_stream(hatch_sfx)
	$Sfx.play()
	spawn_chick()
	disable_collide()
	$DeleteShellTimer.start()

func make_static():
	set_deferred("mode", MODE_STATIC)

func spawn_chick():
	var chick = CHICK.instance()
	chick.position = position
	game_scene.call_deferred("add_child", chick)

func score():
	get_tree().current_scene.current_score += SCORE_VALUE
	var pop_up_score = POP_UP_SCORE.instance()
	pop_up_score.set_position(position)
	game_scene.call_deferred("add_child", pop_up_score)
	pop_up_score.call_deferred("start", -1, 50, "+" + str(SCORE_VALUE))
