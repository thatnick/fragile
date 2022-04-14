# DEBUG
extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _ready():
	# set the debug GUI control defaults from the manager
	$GravityEdit.text = str(manager.gravity)
	$VelDampEdit.text = str(manager.vel_damp)
	$RotVelDampEdit.text = str(manager.rot_vel_damp)
	$EggSpinCheckbox.pressed = manager.egg_spin_on_start
	$ClampEggVelocity.text = str(manager.clamp_egg_velocity)
	$EggIntervalEdit.text = str(manager.egg_interval)
	$LivesEdit.text = str(manager.lives_total)
	$BirdSpeedEdit.text = str(manager.bird_speed)
	

func _on_StartGameButton_pressed():
	# save the current debug values from the GUI controls into the manager
	manager.gravity = float($GravityEdit.text)
	manager.vel_damp = float($VelDampEdit.text)
	manager.rot_vel_damp = float($RotVelDampEdit.text)
	manager.egg_spin_on_start = $EggSpinCheckbox.pressed
	manager.clamp_egg_velocity = float($ClampEggVelocity.text)
	manager.egg_interval = int($EggIntervalEdit.text)
	manager.lives_total = int($LivesEdit.text)
	manager.bird_speed = float($BirdSpeedEdit.text)

	manager.next_level()

