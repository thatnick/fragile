extends CanvasLayer

func _ready():
	$Sfx.play()

func _process(_delta):
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://screens/debug_options.tscn")

func _on_Button_pressed():
	# DEBUG
	get_tree().change_scene("res://screens/debug_options.tscn")
