extends Path2D

const EGG = preload("res://egg/egg.tscn")
const BOMB = preload("res://bomb/bomb.tscn")

var speed = 250

onready var manager = get_node("/root/Manager")

func _ready():
	# stop at the end of the path instead of looping back to the start
	$Bird.set_loop(false)
	$EggSpawnTimer.wait_time = manager.get_current_level_scene().egg_lay_interval
	$EggSpawnTimer.start()

func _process(delta):
	# move bird along the path
	$Bird.offset += speed * delta
	# reverse when reaching the end of the path
	if ($Bird.unit_offset >= 1 || $Bird.unit_offset <= 0):
		speed = -speed
		$Bird/AnimatedSprite.flip_h = !$Bird/AnimatedSprite.flip_h

func _on_EggSpawnTimer_timeout():
	spawn_egg()

func _on_BombSpawnTimer_timeout():
	spawn_bomb()

func spawn_bomb():
	var bomb = BOMB.instance()
	bomb.position = $Bird.position
	manager.get_current_level_scene().add_child(bomb)

func spawn_egg():
	var egg = EGG.instance()
	egg.position = $Bird.position
	manager.get_current_level_scene().add_child(egg)
	$Sfx.play()
