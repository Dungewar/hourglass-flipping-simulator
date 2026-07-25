extends Node2D
class_name Rock

var dragging: bool = false
var rock_offset: Vector2 = Vector2(0, 0)
var game_start_position: Vector2
var last_seen_hourglass_without_rock: Hourglass = null

func _ready() -> void:
	game_start_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - rock_offset


func _on_drag_button_button_down() -> void:
	dragging = true
	rock_offset = get_global_mouse_position() - global_position

# Error is because we assume it's global position when it's really relative to hourglass

func _on_drag_button_button_up() -> void:
	dragging = false
	# if close to other hourglass, attach to it, otherwise snap back
	if last_seen_hourglass_without_rock != null:
		# Now change yourself to be that guy's parent
		self.reparent(last_seen_hourglass_without_rock)
	snap_back()

func snap_back():
	create_tween().tween_property(self, "position", game_start_position, 0.15).set_trans(Tween.TRANS_QUART)
	print("Start: ", game_start_position)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Hourglass:
		var hourglass_children: Array[Node] = area.get_children()
		for child in hourglass_children:
			if child is Rock:
				# Already a rock there, just like say NO to reparenting
				return
		last_seen_hourglass_without_rock = area
