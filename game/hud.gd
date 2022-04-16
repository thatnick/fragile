extends CanvasLayer
class_name HUD

onready var manager = get_node("/root/Manager")

func _ready():
	manager.connect("level_ready", self, "_on_level_ready")
	
	
	
func _process(_delta):
	$CurrentScoreLabel.text = str(manager.get_current_level_scene().current_score)

func _on_level_ready():
	$TargetScoreLabel.text = str(manager.get_current_level_scene().target_score)
