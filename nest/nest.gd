class_name Nest
extends KinematicBody2D

onready var manager = get_node("/root/Manager")

const SPEED = 500

var velocity = Vector2()

func get_input():
	velocity.x = 0;
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
