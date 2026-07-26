extends Node
class_name GamePlayer

# spawn stuff
var time_since_start: float = 0
@export var event_interval: float = 1
@export var rock_chance: float = 0.2
var last_event_time: float = 0

# node stuff
@export var game_over_screen: Node2D
@export var level_complete_screen: Node2D
@onready var collect_cheese_minigame_scene = preload("res://scenes/minigames/collect_cheese/collect_cheese_minigame.tscn")
@onready var spaceship_minigame_scene = preload("res://scenes/minigames/spaceship/spaceship_minigame.tscn")

# level stuff
var spawn_index: int = 0
var current_level_plan: LevelPlanner.LevelPlan = null
var num_hourglasses_cleared: int = 0

func _ready() -> void:
	GM.game_player = self
	load_level(GM.current_level_number)

func load_level(level_number: int):
	GM.current_level_number = level_number
	spawn_index = 0
	current_level_plan = GM.LEVEL_PLANS[GM.current_level_number - 1]
	num_hourglasses_cleared = 0

func _process(delta: float) -> void:
	time_since_start += delta
	
	var planned_spawns: Array[LevelPlanner.HourglassSpawn] = current_level_plan.hourglass_spawns
	if spawn_index < len(planned_spawns) and time_since_start > planned_spawns[spawn_index].spawn_time:
		var spawn: LevelPlanner.HourglassSpawn = planned_spawns[spawn_index]
		GM.hourglass_manager.add_hourglass(spawn.minigame_scene, spawn.hourglass_max_time, spawn.has_rock, spawn.minigame_params)
		spawn_index += 1
	
	# OLD RANDOM SPAWN
	#if time_since_start > last_event_time + event_interval:
		#if GM.hourglass_manager.can_spawn():
			#last_event_time = time_since_start
			#
			#var random_number = randf()
			#var will_have_rock: bool = randf() < rock_chance
			#
			#if random_number < 0.5:
				#GM.hourglass_manager.add_hourglass(collect_cheese_minigame_scene, 20, will_have_rock)
			#else:
				#GM.hourglass_manager.add_hourglass(spaceship_minigame_scene, 60, will_have_rock)

func on_hourglass_cleared():
	num_hourglasses_cleared += 1
	if num_hourglasses_cleared >= GM.LEVEL_PLANS[GM.current_level_number - 1].num_hourglasses_to_win:
		create_tween().tween_property(level_complete_screen, "position", Vector2(0, 0), 1.5).set_trans(Tween.TRANS_QUART)

func on_hourglass_broke():
	GM.minigame_viewer.close_current_minigame()
	create_tween().tween_property(game_over_screen, "position", Vector2(0, 0), 1.5).set_trans(Tween.TRANS_QUART)


func _on_main_menu_button_pressed() -> void:
	print("Going to the main menu...")
	get_tree().change_scene_to_file("res://scenes/menus/main_menu_screen.tscn")


func _on_retry_button_pressed() -> void:
	print("Restarting game...")
	get_tree().change_scene_to_file("res://scenes/menus/game.tscn")


func _on_next_level_button_pressed() -> void:
	print('Next level...')
	GM.current_level_number += 1
	get_tree().change_scene_to_file("res://scenes/menus/game.tscn")
