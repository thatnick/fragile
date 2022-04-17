extends CanvasLayer
class_name HUD

onready var manager = get_node("/root/Manager")

func _process(_delta):
	$CurrentScoreLabel.text = str(manager.get_current_level_scene().current_score)
	$TimeLeftLabel.text = str(manager.get_current_level_scene().time_left)
