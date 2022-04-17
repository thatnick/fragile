# DEBUG
extends CanvasLayer

onready var manager = get_node("/root/Manager")

func _ready():
	# set the debug GUI control defaults from the manager
	
	for level_file_path in manager.level_file_paths:
		$LvlOptionButton.add_item(level_file_path)

func _on_StartGameButton_pressed():
	# save the current debug values from the GUI controls into the manager
	
	manager.lvl = $LvlOptionButton.get_selected_id() + 1
	manager.load_level($LvlOptionButton.get_item_text($LvlOptionButton.get_selected_id()))
