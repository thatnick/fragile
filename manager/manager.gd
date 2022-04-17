#Game manager script

extends Node

signal level_ready

var level_running = false setget set_level_running

var rng = RandomNumberGenerator.new()

var lvl = 1
const LEVELS_FOLDER = "res://levels/"
var level_file_paths = []

var last_level_score = 0
var scores = []
var total_score = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	rng.randomize()
	init_level_paths()
	
func show_story():
	get_tree().change_scene("res://screens/story.tscn")
	
func new_game():
	lvl = 1
	next_level()

func load_level(lvl_path):
	get_tree().change_scene(lvl_path)

func next_level():
	load_level(get_level_file_path())

func retry_level():
	next_level()

func level_complete(final_score):
	last_level_score = final_score
	scores.push_back(final_score.actual)
	lvl += 1
	if !lvl > level_file_paths.size():
		get_tree().change_scene("res://screens/level_complete.tscn")
	else:
		game_complete()

func restart_game():
	get_tree().change_scene("res://screens/start.tscn")

func game_complete():
	for score in scores:
		total_score += score
	get_tree().change_scene("res://screens/game_complete.tscn")
	
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

func get_level_file_path():
	return level_file_paths[lvl - 1]

func get_current_level_scene():
	return get_tree().current_scene

func set_level_running(new_value):
	level_running = new_value
	emit_signal("level_ready")
