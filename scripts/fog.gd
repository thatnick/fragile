extends Area2D

onready var manager = get_node("/root/Manager")
const SPEED = 50
var direction = Vector2(1, 0)
var dynamic = false


func _ready():
	set_linear_damp(manager.fog_linear_damp)
	if $Dynamic:
		dynamic = true
	if $Left:
		direction.x = -1

func _physics_process(delta):
	if dynamic:
		position.x += direction.x * SPEED * delta


func _on_Fog_body_entered(body):
	if body.get_class() == "Wall":
		if direction.x == 1:
			direction.x = -1
		elif direction.x == -1:
			direction.x = 1

