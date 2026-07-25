extends Node2D
class_name Cheese

var minigame: CollectCheeseMinigame

func _ready() -> void:
	z_index = 101

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				minigame.on_collect()
				get_parent().remove_child(self)
				queue_free()
