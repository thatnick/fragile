extends Area2D


const EXPLOSION_FORCE = 150

var explosion_vector = Vector2(0, -1)

func _ready():
	$AnimatedSprite.play("explosion")
	$Sfx.play()
	

func _on_Explosion_body_entered(body):
	if body is Chick:
		if body.get_position().x >= position.x:
			explosion_vector.x = 1
		else:
			explosion_vector.x = -1
		body.explosion_impulse(explosion_vector, EXPLOSION_FORCE)


func _on_AnimatedSprite_animation_finished():
	queue_free()

