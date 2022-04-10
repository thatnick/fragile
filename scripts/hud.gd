extends CanvasLayer
class_name HUD

onready var manager: Node = get_node("/root/Manager")

func _ready():
	$ScoreNum.text = str(manager.score)
	$LivesNum.text = str(manager.lives)
	$LivesTotal.text = str(manager.lives_total)
	
func _physics_process(delta):
	$ScoreNum.text = str(manager.score)
	$LivesNum.text = str(manager.lives)

