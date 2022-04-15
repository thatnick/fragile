#Game manager script

extends Node

var game_running = false

var rng = RandomNumberGenerator.new()

var score: int = 0
var lives
var lvl = 1 setget set_level
const LEVELS_FOLDER = "res://scenes/levels"
var level_paths = []

# DEBUG these are overriden by any changes on the DebugOptions screen
var clamp_egg_velocity = 500.0
var gravity = 1
var vel_damp = 0.025
var rot_vel_damp = 0.5
var egg_spin_on_start = true
var egg_interval = 3
var lives_total = 3 setget set_lives_total
var bird_speed = 250

func _ready():
	rng.randomize()
	init_level_paths()
	
func _process(delta):
	if (game_running && lives <= 0):
		game_over()
		
func set_lives_total(new_value):
	lives_total = new_value
	lives = lives_total

func game_over():
	set_level(lvl + 1)
	get_tree().change_scene("res://scenes/game_over.tscn")

#TODO - function to progress to next level
func next_level():
	load_level(level_paths[lvl - 1])

func load_level(lvl_path):
	get_tree().change_scene(lvl_path)

#TODO - function to set up game to play from start
func new_game():
	set_level(1)
	next_level()

#TODO - function to retry the existing level
func retry():
	print("Retry method was called!")

#Function to return player to start screen
func start_screen():
	get_tree().change_scene("res://scenes/start.tscn")
	
func init_level_paths():
	var dir = Directory.new()
	if dir.open(LEVELS_FOLDER) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				level_paths.push_back(LEVELS_FOLDER + "/" + file_name)
			file_name = dir.get_next()
	level_paths.sort()

func set_level(new_value):
	if new_value > level_paths.size():
		lvl = 1
	else:
		lvl = new_value
