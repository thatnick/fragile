#Game manager script

extends Node

var rng = RandomNumberGenerator.new()

var score: int = 0
var lives: int = 3

var lives_total
var gravity
var vel_damp
var rot_vel_damp
var egg_interval

func _ready():
	rng.randomize()
