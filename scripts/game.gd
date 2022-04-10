extends Node

onready var manager = get_node("/root/Manager")

func _ready():
	manager.game_running = true

func _process(delta):
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/debug_options.tscn")
	
func _exit_tree():
	manager.game_running = false

