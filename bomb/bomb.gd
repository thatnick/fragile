class_name Bomb
extends KinematicBody2D

const BOUNCE_SFX = preload("res://bomb/sfx/hit_6.wav")
const EXPLOSION = preload("res://explosion/explosion.tscn")
const SPEED_MULTIPLIER = 1
const BAT_AWAY_SPEED_MULTIPLIER = 2

var in_air = true
var is_moving = true
var gravity_vector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = SPEED_MULTIPLIER
var velocity = Vector2()

onready var game_scene = get_parent()
onready var sfx = $Sfx

func _ready():
	velocity = gravity_vector * gravity_magnitude
	velocity = velocity.rotated(rand_range(-PI / 4, PI / 4))

func _physics_process(delta):
	rotation = velocity.angle()
	if is_moving:
		var collision = move_and_collide(velocity * speed * delta, false)
		if collision:
			if collision.collider is Floor:
				hit_floor()
			else:
				velocity = velocity.bounce(collision.normal)
				rotation = velocity.angle()
				if collision.collider is Nest:
					collision.collider.bat_away()
					sfx.set_stream(BOUNCE_SFX)
					sfx.play()
					$BatAwayTimer.start()
					speed = BAT_AWAY_SPEED_MULTIPLIER

func _on_BombTimer_timeout():
	explode()

func _on_BatAwayTimer_timeout():
	speed = SPEED_MULTIPLIER

func explode():
	var explosion = EXPLOSION.instance()
	explosion.position = position
	explosion.get_node("CollisionShape2D").set_disabled(in_air)
	game_scene.call_deferred("add_child", explosion)
	queue_free()

func hit_floor():
	in_air = false
	explode()
	is_moving = false


