class_name Lvl
extends Node

onready var manager = get_node("/root/Manager")

var current_score = 0
var target_score = 3

var total_lives = 3 setget set_total_lives
var current_lives

func _ready():
	current_lives = total_lives
	manager.level_running = true

func _process(_delta):
	if current_lives <= 0:
		manager.game_over()
	
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://screens/debug_options.tscn")

func _exit_tree():
	manager.level_running = false

func set_total_lives(new_value):
	total_lives = new_value
	current_lives = total_lives
