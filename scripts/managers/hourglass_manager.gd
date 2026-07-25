extends Node2D
class_name HourglassManager

@export var hourglass_max_spawns: int = 6
@export var hourglass_spawn_interval: int = 3
var hourglass_list: Array[Hourglass] = []
var hourglass_scene: PackedScene = preload("res://scenes/objects/hourglass.tscn")

# Graphics
var hourglass_width = 350
var hourglass_start_position = -500

func _ready():
	GM.hourglass_manager = self

func can_spawn():
	return hourglass_list.size() < hourglass_max_spawns

func add_hourglass(minigame: Minigame = null) -> Hourglass:
	var hourglass: Hourglass = hourglass_scene.instantiate();
	add_child(hourglass)
	
	minigame.hourglass = hourglass
	hourglass.minigame = minigame
	hourglass.is_button_visible = (minigame != null)
	hourglass.position = Vector2(hourglass_start_position+hourglass_width * hourglass_list.size(), 0)
	
	hourglass_list.append(hourglass)
	return hourglass

func remove_hourglass(hourglass: Hourglass):
	hourglass_list.erase(hourglass)
	hourglass.queue_free()
	
	# shift hourglasses to the left
	for i in range(0, hourglass_list.size()):
		var target_position: Vector2 = Vector2(hourglass_start_position + hourglass_width * i, 0)
		create_tween().tween_property(hourglass_list.get(i), "position", target_position, 0.5).set_trans(Tween.TRANS_QUART)
