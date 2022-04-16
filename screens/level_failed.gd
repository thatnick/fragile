extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _on_RetryLevelButton_pressed():
	manager.retry_level()
