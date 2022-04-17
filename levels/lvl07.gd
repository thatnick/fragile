extends Lvl

func _ready():
	if manager.choc_mode:
		$Game/EggGen/Bird/AnimatedSprite.animation = "bunny"
