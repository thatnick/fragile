extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _ready():
	$Sfx.play()

func _on_RestartGameButton_pressed():
	manager.restart_game()
