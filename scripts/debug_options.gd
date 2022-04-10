# DEBUG
extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _ready():
	$GravityEdit.text = str(manager.gravity)
	$VelDampEdit.text = str(manager.vel_damp)
	$RotVelDampEdit.text = str(manager.rot_vel_damp)
	$EggIntervalEdit.text = str(manager.egg_interval)
	$LivesEdit.text = str(manager.lives_total)

func _on_StartGameButton_pressed():
	manager.gravity = float($GravityEdit.text)
	manager.vel_damp = float($VelDampEdit.text)
	manager.rot_vel_damp = float($RotVelDampEdit.text)
	manager.egg_interval = int($EggIntervalEdit.text)
	manager.lives_total = int($LivesEdit.text)
	
	get_tree().change_scene("res://scenes/game.tscn")
