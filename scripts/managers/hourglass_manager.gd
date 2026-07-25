extends Node2D
class_name HourglassSpawner

var hourglass_scene: PackedScene = preload("res://scenes/objects/hourglass.tscn")

# Graphics
var hourglass_width = 350
var hourglass_start_position = -500

func _ready():
	GM.hourglass_spawner = self

func add_hourglass() -> Hourglass:
	var hourglass: Hourglass = hourglass_scene.instantiate();
	hourglass.position = Vector2(hourglass_start_position+hourglass_width * GM.game_player.hourglass_list.size(), 0)
	GM.game_player.hourglass_list.append(hourglass)
	add_child(hourglass)
	return hourglass

func remove_hourglass(hourglass: Hourglass):
	GM.game_player.hourglass_list.erase(hourglass)
	hourglass.queue_free()
	
	# shift hourglasses to the left
	for i in range(0, GM.game_player.hourglass_list.size()):
		var target_position: Vector2 = Vector2(hourglass_start_position + hourglass_width * i, 0)
		create_tween().tween_property(GM.game_player.hourglass_list.get(i), "position", target_position, 0.5).set_trans(Tween.TRANS_QUART)
	
	#if hourglass_list.size() > 0:
		#hourglass_list.pop_back()
