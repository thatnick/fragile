#Game manager script

extends Node

var game_running = false

var rng = RandomNumberGenerator.new()

var score: int = 0
var lives
var lvl = 1

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
	
func _process(delta):
	if (game_running && lives <= 0):
		game_over()
		
func set_lives_total(new_value):
	lives_total = new_value
	lives = lives_total

func game_over():
	lvl += 1
	get_tree().change_scene("res://scenes/game_over.tscn")
