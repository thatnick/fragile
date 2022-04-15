class_name Cloud
extends KinematicBody2D

const SPEED = 50

var direction = Vector2(1, 0)

onready var manager = get_node("/root/Manager")

enum Mode {STATIC, MOVING}
export(Mode) var mode = Mode.MOVING

enum Dir {LEFT = -1, RIGHT = 1}
export(Dir) var initial_dir = Dir.LEFT

func _ready():
	if mode == Mode.MOVING:
		direction.x = initial_dir

func _physics_process(delta):
	if mode == Mode.MOVING:
		var collision = move_and_collide(direction * SPEED * delta)
		if collision:
			if collision.collider is Wall:
				direction.x = -direction.x
