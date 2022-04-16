class_name Nest
extends KinematicBody2D

onready var manager = get_node("/root/Manager")

const SPEED = 500

var velocity = Vector2()

func get_input():
	velocity.x = 0;
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		$NestHen/AnimatedSprite.set_flip_h(true)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
		$NestHen/AnimatedSprite.set_flip_h(false)

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
