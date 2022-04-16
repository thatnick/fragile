extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _on_NextLevelButton_pressed():
	manager.next_level()
