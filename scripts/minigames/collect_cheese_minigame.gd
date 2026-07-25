extends Minigame
class_name CollectCheeseMinigame

var cheeses_required = 10
var cheese_scene: PackedScene = preload("res://scenes/minigames/collect_cheese/cheese.tscn")
@onready var score: Label = $Score
var time_since_spawn: float = 0
var cheeses_collected: int = 0:
	set(val):
		cheeses_collected = val
		score.text = 'Cheese collected: %d/%d' % [cheeses_collected, cheeses_required]
		if cheeses_collected == cheeses_required:
			finish()

func _process(delta: float) -> void:
	if GM.minigame_viewer and (GM.minigame_viewer.minigame != self or not GM.minigame_viewer.is_open):
		return
	time_since_spawn += delta
	if time_since_spawn > 0.5:
		spawn_cheese()
		time_since_spawn = 0

func spawn_cheese():
	var cheese: Cheese = cheese_scene.instantiate()
	add_child(cheese)
	cheese.minigame = self
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		var size = get_viewport_rect().size * camera.zoom
		var top_left = camera.global_position - size / 2.0
		cheese.global_position = Vector2(
			randf_range(top_left.x, top_left.x + size.x),
			randf_range(top_left.y, top_left.y + size.y)
		)

func on_collect():
	print('collect')
	cheeses_collected += 1
