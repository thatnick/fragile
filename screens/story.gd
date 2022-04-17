extends CanvasLayer

onready var manager: Node = get_node("/root/Manager")

func _on_ContinueButton_pressed():
	manager.new_game()
