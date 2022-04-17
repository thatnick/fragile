extends AudioStreamPlayer


const LOOP_A: Resource = preload("res://music_player/music/loop_a.mp3")
const LVL_MUSIC: Resource = preload("res://music_player/music/eggytoss_gameplay_loop.mp3")
const START_MENU_MUSIC: Resource = preload("res://music_player/music/start_menu_music.mp3")

func menu_music():
	set_stream(START_MENU_MUSIC)
	play()

func lvl_music():
	set_stream(LVL_MUSIC)
	play()
	

func pause_music():
	set_stream(LOOP_A)
	play()
	
