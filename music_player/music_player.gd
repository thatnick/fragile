extends AudioStreamPlayer

var start_menu_music: Resource = preload("res://music_player/music/start_menu_music.mp3")
var loop_a: Resource = preload("res://music_player/music/loop_a.mp3")
var loop_b: Resource = preload("res://music_player/music/loop_b.mp3")
var loop_c: Resource = preload("res://music_player/music/loop_c.mp3")
var fast_loop_a: Resource = preload("res://music_player/music/fast_loop_a.mp3")

func menu_music():
	set_stream(start_menu_music)
	play()

func lvl_music():
	set_stream(loop_b)
	play()

func pause_music():
	set_stream(loop_a)
	play()
