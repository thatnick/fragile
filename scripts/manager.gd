#Game manager script

extends Node

var game_running = false

var rng = RandomNumberGenerator.new()

var score: int = 0
var lives

var lives_total = 3 setget set_lives_total
var gravity = 1
var vel_damp = 0.025
var rot_vel_damp = 0.5
var egg_interval = 3

func _ready():
	rng.randomize()
	#lives = lives_total
	
func _process(delta):
	if (game_running && lives <= 0):
		get_tree().change_scene("res://scenes/game_over.tscn")
		
func set_lives_total(new_value):
	lives_total = new_value
	lives = lives_total
