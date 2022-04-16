extends CanvasLayer
class_name HUD

func _ready():
	$TargetScoreLabel.text = str(get_tree().current_scene.target_score)
	
func _process(_delta):
	$CurrentScoreLabel.text = str(get_tree().current_scene.current_score)
