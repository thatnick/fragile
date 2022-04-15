class_name Start

extends Control

onready var manager: Node = get_node("/root/Manager")

func _process(delta) -> void:
	if Input.is_action_pressed("ui_accept"):
		manager.new_game()

