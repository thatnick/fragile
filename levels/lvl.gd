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

var level_timer = Timer.new()
var level_complete_timer = Timer.new()
var time_left

func _ready():
	calc_target_score()
	setup_timers()
	start_level()
	manager.level_running = true

func _process(_delta):
	time_left = int(level_timer.time_left)
		
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://screens/debug_options.tscn")

func _exit_tree():
	manager.level_running = false
	
func _on_level_timer_timeout():
	level_complete()

func _on_level_complete_timer_timeout():
	manager.level_complete()

func calc_target_score():
	var max_score = (time_limit_secs - EGG_FALL_TIME_SECS) / egg_lay_interval
	target_score = max_score * SCORE_MULTIPLIER * (GOLD_SCORE_PERCENT / 100.0)

func setup_timers():
	level_timer.one_shot = true
	level_complete_timer.one_shot = true
	add_child(level_timer)
	add_child(level_complete_timer)
	level_timer.connect("timeout", self, "_on_level_timer_timeout")
	level_complete_timer.connect("timeout", self, "_on_level_complete_timer_timeout")

func start_level():
	level_timer.start(time_limit_secs)

func level_complete():
	level_complete_timer.start(3)
