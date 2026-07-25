extends Node
class_name GamePlayer

#var _buffer: Countdown = Countdown.new()
var time_since_start: float = 0
@export var event_interval: float = 10
@export var game_over_screen: Node2D
var last_event_time: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.game_player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_start += delta
	if last_event_time + event_interval > time_since_start:
		last_event_time = time_since_start
		# trigger random event

func hourglass_broke(hourglass: Hourglass):
	GM.hourglass_spawner.remove_hourglass(hourglass)
	#game_over_screen.show()
	create_tween().tween_property(game_over_screen, "position", Vector2(0, 0), 1.5).set_trans(Tween.TRANS_QUART)


func _on_main_menu_button_pressed() -> void:
	print("Going to the main menu...")


func _on_retry_button_pressed() -> void:
	print("Restarting game...")
	get_tree().change_scene_to_file("res://scenes/main.tscn")
