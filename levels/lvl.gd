class_name Lvl
extends Node

onready var manager = get_node("/root/Manager")

var current_score = 0
var target_score = 3

func _ready():
	manager.level_running = true

func _process(_delta):
	if current_score >= target_score:
		manager.lvl += 1
		get_tree().change_scene("res://screens/next_level.tscn")
	
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://screens/debug_options.tscn")

func _exit_tree():
	manager.level_running = false
