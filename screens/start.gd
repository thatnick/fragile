extends CanvasLayer

onready var manager: Node = get_node("/root/Manager")

func _on_NewGameButton_pressed():
	manager.new_game()
