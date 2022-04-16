class_name Bomb
extends KinematicBody2D

const EXPLOSION = preload("res://explosion/explosion.tscn")

var in_air = true
var is_moving = true
var gravity_vector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2()

onready var game_scene = get_parent()


func _ready():
	velocity = gravity_vector * gravity_magnitude

func _physics_process(delta):
	if is_moving:
		var collision = move_and_collide(velocity * delta)
		if collision:
			if collision.collider is Floor:
				hit_floor()
			else:
				velocity = velocity.bounce(collision.normal)
			
			if collision.collider is NestHen:
				collision.collider.bat_away()
	

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


func _on_Timer_timeout():
	explode()

