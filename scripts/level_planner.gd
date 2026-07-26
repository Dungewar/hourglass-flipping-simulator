class_name LevelPlanner

var collect_cheese_minigame_scene: PackedScene = preload("res://scenes/minigames/collect_cheese/collect_cheese_minigame.tscn")
var spaceship_minigame_scene: PackedScene = preload("res://scenes/minigames/spaceship/spaceship_minigame.tscn")

func get_global_level_plans() -> Array[LevelPlan]:
	return [
		# level_number, hourglass_spawns (array), num_hourglasses_to_win (default auto),
		LevelPlan.new(
			1,
			[
				# spawn_time, hourglass_max_time, has_rock, minigame, minigame_params
				HourglassSpawn.new(0, 20, false, collect_cheese_minigame_scene, {'cheeses_required': 20}),
				HourglassSpawn.new(2, 10, false, collect_cheese_minigame_scene, {'cheeses_required': 3}),
			],
		),
		LevelPlan.new(
			2,
			[
				# spawn_time, hourglass_max_time, has_rock, minigame, minigame_params
				HourglassSpawn.new(0, 20, false, spaceship_minigame_scene, {'meteor_count': 10, 'meteor_spawn_interval': 0.4}),
				HourglassSpawn.new(10, 10, true, spaceship_minigame_scene, {'meteor_count': 10, 'meteor_spawn_interval': 0.2}),
				HourglassSpawn.new(15, 10, false, spaceship_minigame_scene, {'meteor_count': 10, 'meteor_spawn_interval': 0.1}),
			],
		),
		LevelPlan.new(
			3,
			[
				# spawn_time, hourglass_max_time, has_rock, minigame, minigame_params
				HourglassSpawn.new(0, 20, false, spaceship_minigame_scene, {'meteor_count': 10, 'meteor_spawn_interval': 0.1}),
				HourglassSpawn.new(5, 10, true, collect_cheese_minigame_scene, {'cheeses_required': 20}),
				HourglassSpawn.new(10, 15, true, spaceship_minigame_scene, {'meteor_count': 10, 'meteor_spawn_interval': 0.1}),
				HourglassSpawn.new(15, 10, false, collect_cheese_minigame_scene, {'cheeses_required': 20}),
				HourglassSpawn.new(20, 20, false, collect_cheese_minigame_scene, {'cheeses_required': 20}),
			],
		),
	]

class HourglassSpawn:
	var spawn_time: int
	var hourglass_max_time: int
	var has_rock: bool
	var minigame_scene: PackedScene
	var minigame_params: Dictionary
	
	@warning_ignore("shadowed_variable")
	func _init(
		spawn_time: int,
		hourglass_max_time: int,
		has_rock: bool,
		minigame_scene: PackedScene = null,
		minigame_params: Dictionary = {}
	):
		self.spawn_time = spawn_time
		self.hourglass_max_time = hourglass_max_time
		self.has_rock = has_rock
		self.minigame_scene = minigame_scene
		self.minigame_params = minigame_params

class LevelPlan:
	var level_number: int
	var hourglass_spawns: Array[HourglassSpawn] = []
	var num_hourglasses_to_win: int
	
	@warning_ignore("shadowed_variable")
	func _init(
		level_number: int,
		hourglass_spawns: Array[HourglassSpawn],
		num_hourglasses_to_win: int = -1,
	):
		self.level_number = level_number
		self.hourglass_spawns = hourglass_spawns
		self.num_hourglasses_to_win = len(hourglass_spawns) if num_hourglasses_to_win == -1 else num_hourglasses_to_win
