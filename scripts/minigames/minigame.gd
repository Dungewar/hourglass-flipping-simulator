extends Node2D
class_name Minigame

var hourglass: Hourglass


func init(hourglass1: Hourglass) -> void:
	hourglass = hourglass1

func finish():
	GM.hourglass_manager.remove_hourglass(hourglass)
	GM.minigame_viewer.close_current_minigame()
	queue_free()

func retry_minigame():
	pass
