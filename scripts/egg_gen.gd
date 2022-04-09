extends Path2D

const EGG = preload("res://scenes/egg.tscn")

var speed = 250

onready var game_scene = get_node("/root/Game")

func _ready():
	# stop at the end of the path instead of looping back to the start
	$Bird.set_loop(false)

func _process(delta):
	# move along the path
	$Bird.offset += speed * delta
	#reverse when reaching the end of the path
	if ($Bird.unit_offset >= 1 || $Bird.unit_offset <= 0):
		speed = -speed

func _on_EggSpawnTimer_timeout():
	spawn_egg()

func spawn_egg():
	var egg = EGG.instance()
	egg.position = $Bird.position
	game_scene.add_child(egg)

# Chang how frequently eggs are layed
func change_spawn_interval(seconds):
	$EggSpawnTimer.wait_time = seconds
