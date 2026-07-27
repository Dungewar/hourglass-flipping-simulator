extends Minigame
class_name CollectCheeseMinigame

# params
var num_cheeses_required: int = 3
var spawn_delay: float = 0.5
var mouse_speed: float = 500

# internal game stuff
var cheese_scene: PackedScene = preload("res://scenes/minigames/collect_cheese/cheese.tscn")
@onready var score: Label = $Score
var time_since_spawn: float = 0
var num_cheeses_collected: int = 0:
	set(val):
		num_cheeses_collected = val
		score.text = 'Cheese collected: %d/%d' % [num_cheeses_collected, num_cheeses_required]
		if num_cheeses_collected == num_cheeses_required:
			show_victory_popup()

func set_params(params: Dictionary):
	if params.has('num_cheeses_required'):
		self.num_cheeses_required = params['num_cheeses_required']
	if params.has('spawn_delay'):
		self.spawn_delay = params['spawn_delay']
	if params.has('mouse_speed'):
		self.mouse_speed = params['mouse_speed']

func _process(delta: float) -> void:
	if GM.minigame_viewer and (GM.minigame_viewer.minigame != self or not GM.minigame_viewer.is_open):
		return
	time_since_spawn += delta
	if time_since_spawn > spawn_delay:
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
	num_cheeses_collected += 1

func _on_mouse_rodent_area_entered(colliding_object: Area2D) -> void:
	#if colliding_object is Cheese:
		#on_collect()
		#colliding_object.queue_free()
		#remove_child(colliding_object)
	pass
