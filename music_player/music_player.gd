extends AudioStreamPlayer

var start_menu_music: Resource = preload("res://music_player/music/start_menu_music.mp3")
var loop_a: Resource = preload("res://music_player/music/loop_a.mp3")
var loop_b: Resource = preload("res://music_player/music/loop_b.mp3")
var loop_c: Resource = preload("res://music_player/music/loop_c.mp3")
var fast_loop_a: Resource = preload("res://music_player/music/fast_loop_a.mp3")

var played_loop_b: bool = false

func menu_music():
	set_stream(start_menu_music)
	play()

func lvl_music():
	if played_loop_b:
		set_stream(loop_c)
		played_loop_b = false
	elif !played_loop_b:
		set_stream(loop_b)
		played_loop_b = true
	play()

func pause_music():
	set_stream(loop_a)
	play()
