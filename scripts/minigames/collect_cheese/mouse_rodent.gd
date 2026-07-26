extends Area2D
class_name MouseRodent

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	if global_position.distance_to(mouse_pos) > 10:
		look_at(mouse_pos)
		var direction = (mouse_pos - global_position).normalized()
		global_position += direction * get_parent().mouse_speed * delta
