class_name NestHen
extends StaticBody2D

const BAT_AWAY = preload("res://bat_away/bat_away.tscn")

func _ready():
	$AnimatedSprite.play("sitting")

func bat_away():
	$AnimatedSprite.play("hitting")
	

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("sitting")
	pass # Replace with function body.
