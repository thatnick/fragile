extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _on_NextLevelTimer_timeout():
	manager.next_level()
