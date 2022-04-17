class_name Chick
extends RigidBody2D

const POP_UP_SCORE = preload("res://pop_up_score/pop_up_score.tscn")
const SPEED = 100
const SCORE_VALUE: int = 10

onready var game_scene = get_parent()

func _ready():
	apply_central_impulse(Vector2(0, -1) * SPEED)

func explosion_impulse(explosion_vector: Vector2, explosion_force: int):
	apply_central_impulse(explosion_vector * explosion_force)
	score()

func score():
	get_tree().current_scene.current_score -= SCORE_VALUE
	var pop_up_score = POP_UP_SCORE.instance()
	pop_up_score.set_position(position)
	game_scene.call_deferred("add_child", pop_up_score)
	pop_up_score.call_deferred("start", -1, 50, "-" + str(SCORE_VALUE), Color.red)
