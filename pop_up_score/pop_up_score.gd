class_name PopUpScore
extends Label

var duration = 0.3

onready var tween = get_node("Tween")

func start(direction: int, distance: int = 12,label_text: String = "+1", color: Color = Color.white):
	text = label_text
	var pos: Vector2 = get_position()
	var end_color = color
	end_color.a = 0.0
	
	tween.interpolate_property(self, "rect_position", pos, Vector2(pos.x, pos.y + distance * direction), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.interpolate_property(self, "modulate", color, end_color, 0.3, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.start()

func _on_Tween_tween_all_completed():
	queue_free()
