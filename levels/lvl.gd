class_name Lvl
extends Node

onready var manager = get_node("/root/Manager")
onready var music_player = get_node("/root/MusicPlayer")

const NEXT_LEVEL_POP_UP = preload("res://game/next_level_pop_up.tscn")
const EGG_FALL_TIME_SECS = 5
const GOLD_SCORE_PERCENT = 75
const SILVER_SCORE_PERCENT = 50
const BRONZE_SCORE_PERCENT = 25
const SCORE_MULTIPLIER = 10

var time_limit_secs = 60
var egg_lay_interval = 3
var bomb_drop_interval = 5
# For every egg dropped, there will be this many bombs dropped
var bombs_per_egg = 0.25
var current_score = 0
var final_score

var level_timer = Timer.new()
var level_complete_timer = Timer.new()
var time_left

func _ready():
	calc_target_scores()
	setup_timers()
	start_level()
	manager.level_running = true

func _process(_delta):
	time_left = int(level_timer.time_left)

func _exit_tree():
	manager.level_running = false
	
func _on_level_timer_timeout():
	final_score.actual = current_score
	level_complete()

func _on_level_complete_timer_timeout():
	get_tree().paused = false
	manager.level_complete(final_score)

func calc_target_scores():
	var max_score = (time_limit_secs - EGG_FALL_TIME_SECS) / egg_lay_interval
	final_score = {
		"gold": max_score * SCORE_MULTIPLIER * (GOLD_SCORE_PERCENT / 100.0),
		"silver": max_score * SCORE_MULTIPLIER * (SILVER_SCORE_PERCENT / 100.0),
		"bronze": max_score * SCORE_MULTIPLIER * (BRONZE_SCORE_PERCENT / 100.0),
		"max": max_score,
		"actual": 0
	}

func setup_timers():
	level_timer.one_shot = true
	level_complete_timer.one_shot = true
	add_child(level_timer)
	add_child(level_complete_timer)
	level_timer.connect("timeout", self, "_on_level_timer_timeout")
	level_complete_timer.connect("timeout", self, "_on_level_complete_timer_timeout")
	level_complete_timer.pause_mode = Node.PAUSE_MODE_PROCESS

func start_level():
	level_timer.start(time_limit_secs)
	music_player.lvl_music()

func level_complete():
	var pop_up = NEXT_LEVEL_POP_UP.instance()
	call_deferred("add_child", pop_up)
	get_tree().paused = true
	level_complete_timer.start(3)
	music_player.pause_music()
