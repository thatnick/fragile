extends AnimatedSprite


func _ready():
	play()
	


func _on_BatAway_animation_finished():
	queue_free()
