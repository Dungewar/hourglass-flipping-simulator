extends Minigame
class_name CollectCheeseMinigame

var cheese_scene: PackedScene = preload("res://objects/collect_cheese/cheese.tscn")

var time_since_spawn: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_spawn += delta
	if time_since_spawn > 2:
		spawn_cheese()
		time_since_spawn = 0

func spawn_cheese():
	print('spawning')
	var cheese: Cheese = cheese_scene.instantiate()
	add_child(cheese)
	var screen_size = get_viewport_rect().size
	cheese.position = Vector2(randf_range(0.0, screen_size.x), randf_range(0.0, screen_size.y))

func on_collect(cheese: Cheese):
	print('collected')
