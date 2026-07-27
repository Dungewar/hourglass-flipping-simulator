extends Area2D

func _on_mouse_entered() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Triggered when the mouse leaves the collision shape
func _on_mouse_exited() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
