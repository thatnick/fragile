#Game manager script

extends Node


var rng = RandomNumberGenerator.new()


var score: int = 0
var lives: int = 3
var lives_total: int = 3

func _ready():
	rng.randomize()


