extends Node
class_name GamePlayer

#var _buffer: Countdown = Countdown.new()
var time_since_start: float = 0
@export var event_interval: float = 1
@export var game_over_screen: Node2D

@onready var collect_cheese_minigame_scene = preload("res://scenes/minigames/collect_cheese/collect_cheese_minigame.tscn")
@onready var spaceship_minigame_scene = preload("res://scenes/minigames/spaceship/spaceship_minigame.tscn")

var last_event_time: float = 0

func _ready() -> void:
	GM.game_player = self

func _process(delta: float) -> void:
	time_since_start += delta
	if time_since_start > last_event_time + event_interval:
		if GM.hourglass_manager.can_spawn():
			last_event_time = time_since_start
			
			GM.hourglass_manager.add_hourglass(collect_cheese_minigame_scene.instantiate())

func hourglass_broke(hourglass: Hourglass):
	GM.hourglass_manager.remove_hourglass(hourglass)
	#game_over_screen.show()
	create_tween().tween_property(game_over_screen, "position", Vector2(0, 0), 1.5).set_trans(Tween.TRANS_QUART)


func _on_main_menu_button_pressed() -> void:
	print("Going to the main menu...")
	get_tree().change_scene_to_file("res://scenes/menus/main_menu_screen.tscn")


func _on_retry_button_pressed() -> void:
	print("Restarting game...")
	get_tree().change_scene_to_file("res://scenes/menus/game.tscn")
