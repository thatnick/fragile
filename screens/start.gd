extends CanvasLayer

onready var manager: Node = get_node("/root/Manager")
onready var music_player: Node = get_node("/root/MusicPlayer")


func _ready():
	music_player.menu_music()

func _on_NewGameButton_pressed():
	manager.new_game()
