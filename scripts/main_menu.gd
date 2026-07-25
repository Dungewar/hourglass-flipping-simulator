extends Node2D
class_name MainMenu

func _on_play_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
