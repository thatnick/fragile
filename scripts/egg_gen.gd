extends Path2D

func _process(delta):
	$Bird.offset += 250 * delta
