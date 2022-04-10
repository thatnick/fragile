#Game manager script

extends Node

var game_running = false

var rng = RandomNumberGenerator.new()

var score: int = 0
var lives

var lives_total = 3
var gravity = 1
var vel_damp = 0.025
var rot_vel_damp = 0.1
var egg_interval = 5

func _ready():
	rng.randomize()
	lives = lives_total
	
func _process(delta):
	if (game_running && lives <= 0):
		get_tree().change_scene("res://scenes/game_over.tscn")
