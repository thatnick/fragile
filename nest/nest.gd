class_name Nest
extends KinematicBody2D

onready var manager = get_node("/root/Manager")
onready var animated_sprite = $AnimatedSprite

const SPEED = 500

var velocity = Vector2()

func _ready():
	animated_sprite.play("sitting")

func get_input():
	velocity.x = 0;
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		animated_sprite.set_flip_h(true)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
		animated_sprite.set_flip_h(false)

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

func bat_away():
	animated_sprite.play("hitting")
	

func _on_AnimatedSprite_animation_finished():
	animated_sprite.play("sitting")
	pass # Replace with function body.
