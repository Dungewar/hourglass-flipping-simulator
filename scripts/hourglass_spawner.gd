extends Node2D
class_name HourglassSpawner

var hourglass_scene: PackedScene = preload("res://objects/hourglass.tscn")
var time: float = 0
var last_spawned: int = 0
@export var max_spawns: int = 6
@export var spawn_interval: int = 3
var hourglass_list: Array[Hourglass] = []

# Graphics
var hourglass_width = 200
var hourglass_start_position = -500

func _ready():
	GM.houglass_spawner = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if time > last_spawned + spawn_interval and hourglass_list.size() < max_spawns:
		MinigameEvent.new().trigger()
		last_spawned = time

func add_hourglass(minigame_event: MinigameEvent = null):
	var hourglass: Hourglass = hourglass_scene.instantiate();
	hourglass.position = Vector2(hourglass_start_position+hourglass_width * hourglass_list.size(), 0)
	
	hourglass.set_minigame_event(minigame_event)
	
	hourglass_list.append(hourglass)
	add_child(hourglass)
	if minigame_event:
		hourglass.is_button_visible = true
		hourglass.minigame_event = minigame_event

func remove_hourglass(hourglass: Hourglass):
	hourglass_list.erase(hourglass)
	hourglass.queue_free()
	
	# shift hourglasses to the left
	for i in range(0, hourglass_list.size()):
		var target_position: Vector2 = Vector2(hourglass_start_position + hourglass_width * i, 0)
		create_tween().tween_property(hourglass_list.get(i), "position", target_position, 0.5).set_trans(Tween.TRANS_QUART)
	
	#if hourglass_list.size() > 0:
		#hourglass_list.pop_back()
