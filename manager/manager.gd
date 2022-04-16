#Game manager script

extends Node

signal level_ready

var level_running = false setget set_level_running
var current

var rng = RandomNumberGenerator.new()

var lvl = 1 setget set_level
const LEVELS_FOLDER = "res://levels/"
var level_file_paths = []

# DEBUG these are overriden by any changes on the DebugOptions screen
var clamp_egg_velocity = 400.0
var fog_linear_damp = 2.0
var gravity = 1
var rot_vel_damp = 0.5
var eggs_collide = false
var bird_speed = 250

func _ready():
	rng.randomize()
	init_level_paths()

#TODO - function to progress to next level
func next_level():
	load_level(get_next_level_file_path())

func load_level(lvl_path):
	get_tree().change_scene(lvl_path)

#TODO - function to set up game to play from start
func new_game():
	set_level(1)
	next_level()

func level_complete():
	pass

func game_complete():
	pass

func level_fail():
	pass

func game_over():
	get_tree().change_scene("res://screens/game_over.tscn")

#TODO - function to retry the existing level
func retry():
	print("Retry method was called!")

#Function to return player to start screen
func start_screen():
	get_tree().change_scene("res://screens/start.tscn")
	
func init_level_paths():
	var dir = Directory.new()
	if dir.open(LEVELS_FOLDER) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() && !".gd" in file_name:
				level_file_paths.push_back(LEVELS_FOLDER + file_name)
			file_name = dir.get_next()
	level_file_paths.sort()

func get_next_level_file_path():
	return level_file_paths[lvl - 1]

func get_current_level_scene():
	return get_tree().current_scene

func set_level(new_value):
	if new_value > level_file_paths.size():
		lvl = 1
	else:
		lvl = new_value

func set_level_running(new_value):
	level_running = new_value
	emit_signal("level_ready")
