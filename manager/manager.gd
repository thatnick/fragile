#Game manager script

extends Node

var level_running = false

var rng = RandomNumberGenerator.new()

var score: int = 0
var lives
var lvl = 1 setget set_level
const LEVELS_FOLDER = "res://levels/"
var level_file_paths = []

# DEBUG these are overriden by any changes on the DebugOptions screen
var clamp_egg_velocity = 500.0
var fog_linear_damp = 2.0
var gravity = 1
var rot_vel_damp = 0.5
var eggs_collide = true
var egg_spin_on_start = true
var egg_interval = 3
var lives_total = 3
var bird_speed = 250

func _ready():
	rng.randomize()
	init_level_paths()

#TODO - function to progress to next level
func next_level():
	load_level(get_next_level_file_path())

func load_level(lvl_path):
	get_tree().change_scene(lvl_path)
	print(get_tree().current_scene)
	
	# DEBUG
	override_level_lives()

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

func set_level(new_value):
	if new_value > level_file_paths.size():
		lvl = 1
	else:
		lvl = new_value

# DEBUG
func override_level_lives():
	yield(get_tree(), "idle_frame")
	if !lives_total == get_tree().current_scene.total_lives:
		get_tree().current_scene.total_lives = lives_total
