class_name Chick
extends RigidBody2D

const POP_UP_SCORE = preload("res://pop_up_score/pop_up_score.tscn")
const CHICK_HALF_WIDTH = 16
const SPEED = 100
const SCORE_VALUE: int = 10

var first_landing = true
var on_floor = false
var first_landing_pos

onready var game_scene = get_parent()

func _ready():
	apply_central_impulse(Vector2(0, -1) * SPEED)

func _process(_delta):
	if !first_landing && on_floor:
		if position.x + CHICK_HALF_WIDTH < first_landing_pos.x:
			chick_run("right")
		elif position.x - CHICK_HALF_WIDTH > first_landing_pos.x:
			chick_run("left")
		else:
			$AnimatedSprite.animation = "floor"
	
func _on_Chick_body_entered(body):
	if body is Floor:
		set_deferred("mode", MODE_STATIC)
		on_floor = true
		$AnimatedSprite.animation = "floor"
		if first_landing:
			first_landing = false
			first_landing_pos = position

func chick_run(direction: String):
	if direction == "right":
		position.x += 1
		$AnimatedSprite.flip_h = true
	elif direction == "left":
		position.x -= 1
		$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "running"

func explosion_impulse(explosion_vector: Vector2, explosion_force: int):
	set_deferred("mode", MODE_RIGID)
	call_deferred("apply_central_impulse", explosion_vector * explosion_force)
	on_floor = false
	$AnimatedSprite.animation = "flight"
	score()

func score():
	get_tree().current_scene.current_score -= SCORE_VALUE
	var pop_up_score = POP_UP_SCORE.instance()
	pop_up_score.set_position(position)
	game_scene.call_deferred("add_child", pop_up_score)
	pop_up_score.call_deferred("start", -1, 50, "-" + str(SCORE_VALUE), Color.red)
