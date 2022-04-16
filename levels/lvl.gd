class_name Lvl
extends Node

onready var manager = get_node("/root/Manager")

const EGG_FALL_TIME_SECS = 5
const GOLD_SCORE_PERCENT = 75
const SILVER_SCORE_PERCENT = 50
const BRONZE_SCORE_PERCENT = 25
const SCORE_MULTIPLIER = 10

var time_limit_secs = 30
var egg_lay_interval = 3
var bomb_drop_interval = 5
# For every egg dropped, there will be this many bombs dropped
var bombs_per_egg = 0.25
var current_score = 0
var target_score

func _ready():
	calc_target_score()
	manager.level_running = true

func _process(_delta):
	if current_score >= target_score:
		manager.lvl += 1
		get_tree().change_scene("res://screens/next_level.tscn")
	
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://screens/debug_options.tscn")

func _exit_tree():
	manager.level_running = false

func calc_target_score():
	var max_score = (time_limit_secs - EGG_FALL_TIME_SECS) / egg_lay_interval
	target_score = max_score * SCORE_MULTIPLIER * (GOLD_SCORE_PERCENT / 100.0)
