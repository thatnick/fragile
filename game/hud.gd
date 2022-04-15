extends CanvasLayer
class_name HUD

func _ready():
	$TotalLivesLabel.text = str(get_tree().current_scene.total_lives)
	$TargetScoreLabel.text = str(get_tree().current_scene.target_score)
	
func _process(_delta):
	$CurrentScoreLabel.text = str(get_tree().current_scene.current_score)
	$CurrentLivesLabel.text = str(get_tree().current_scene.current_lives)
	
	# DEBUG
	$TotalLivesLabel.text = str(get_tree().current_scene.total_lives)

