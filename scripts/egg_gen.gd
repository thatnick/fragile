extends Path2D

var speed = 250

func _ready():
	# stop at the end of the path instead of looping back to the start
	$Bird.set_loop(false)

func _process(delta):
	# move along the path
	$Bird.offset += speed * delta
	#reverse when reaching the end of the path
	if ($Bird.unit_offset >= 1 || $Bird.unit_offset <= 0):
		speed = -speed
