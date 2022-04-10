extends CanvasLayer

func _process(delta):
	# DEBUG
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/debug_options.tscn")

func _on_Button_pressed():
	# DEBUG
	get_tree().change_scene("res://scenes/debug_options.tscn")
