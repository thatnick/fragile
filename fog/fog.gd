extends Area2D

const SPEED = 50

var direction = Vector2(1, 0)

onready var manager = get_node("/root/Manager")

enum Mode {STATIC, MOVING}
export(Mode) var mode = Mode.MOVING

enum Dir {LEFT = -1, RIGHT = 1}
export(Dir) var initial_dir = Dir.LEFT

func _ready():
	set_linear_damp(manager.fog_linear_damp)
	if mode == Mode.MOVING:
		direction.x = initial_dir

func _physics_process(delta):
	if mode == Mode.MOVING:
		position.x += direction.x * SPEED * delta

func _on_Fog_body_entered(body):
	if body is Wall:
		direction.x = -direction.x
