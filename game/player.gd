extends KinematicBody2D

const SPEED = 500
const BOUNCE_SPEED = -750
const GRAVITY = 5000

var bouncing = false
var velocity = Vector2()

func get_input():
	velocity.x = 0;
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("ui_accept") && is_on_floor():
		bouncing = true
		velocity.y = BOUNCE_SPEED
		$BounceSFX.play()

func _physics_process(delta):
	get_input()
	velocity.y += GRAVITY * delta
	if bouncing and is_on_floor():
		bouncing = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
