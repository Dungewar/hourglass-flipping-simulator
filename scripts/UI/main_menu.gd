extends Control
class_name MainMenu

var selected_level: int

func _ready() -> void:
	select_level(1)

func _on_play_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/game.tscn")

@onready var buttons:HBoxContainer = $MarginContainer/VBoxContainer/Buttons

func _on_level_1_pressed() -> void:
	select_level(1)

func _on_level_2_pressed() -> void:
	select_level(2)

func _on_level_3_pressed() -> void:
	select_level(3)

func select_level(level_number: int) -> void:
	for i in range(len(buttons.get_children())):
		buttons.get_children()[i].text = 'Level %d' % (i+1)
	buttons.get_children()[level_number-1].text = '[Selected] Level %d' % (level_number)
	selected_level = level_number
