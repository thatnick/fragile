extends CanvasLayer

onready var manager = get_node("/root/Manager")
onready var music_player: Node = get_node("/root/MusicPlayer")

func _ready():
		music_player.menu_music()
		$BronzeMedal.set_modulate(Color.black)
		$SilverMedal.set_modulate(Color.black)
		$GoldMedal.set_modulate(Color.black)
		
		var score = manager.last_level_score
		$BronzeLabel.text = str(score.bronze) + "+"
		$SilverLabel.text = str(score.silver) + "+"
		$GoldLabel.text = str(score.gold) + "+"
		$ScoreLabel.text = str(score.actual)
		
		if score.actual >= score.gold:
			$GoldMedal.set_modulate(Color.white)
		elif score.actual >= score.silver:
			$SilverMedal.set_modulate(Color.white)
		elif score.actual >= score.bronze:
			$BronzeMedal.set_modulate(Color.white)

func _on_NextLevelButton_pressed():
	manager.next_level()
