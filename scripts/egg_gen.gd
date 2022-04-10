extends Path2D

const EGG = preload("res://scenes/egg.tscn")

var speed = 250

onready var manager = get_node("/root/Manager")
onready var game_scene = get_node("/root/Game")

func _ready():
	# stop at the end of the path instead of looping back to the start
	$Bird.set_loop(false)
	
	speed = manager.bird_speed
	
	# DEBUG Set options from the debug screen
	$EggSpawnTimer.wait_time = manager.egg_interval
	$EggSpawnTimer.start()

func _process(delta):
	# move bird along the path
	$Bird.offset += speed * delta
	# reverse when reaching the end of the path
	if ($Bird.unit_offset >= 1 || $Bird.unit_offset <= 0):
		speed = -speed

func _on_EggSpawnTimer_timeout():
	spawn_egg()

func spawn_egg():
	var egg = EGG.instance()
	egg.position = $Bird.position
	game_scene.add_child(egg)
