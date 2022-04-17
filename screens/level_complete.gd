extends CanvasLayer

onready var manager = get_node("/root/Manager")
onready var music_player: Node = get_node("/root/MusicPlayer")

func _ready():
		music_player.menu_music()

func _on_NextLevelButton_pressed():
	manager.next_level()
