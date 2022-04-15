extends CanvasLayer
class_name HUD

func _ready():
	$TotalLivesLabel.text = str(get_tree().current_scene.total_lives)
	
func _process(delta):
	$CurrentScoreLabel.text = str(get_tree().current_scene.current_score)
	$CurrentLivesLabel.text = str(get_tree().current_scene.current_lives)
	
	# DEBUG
	$TotalLivesLabel.text = str(get_tree().current_scene.total_lives)

