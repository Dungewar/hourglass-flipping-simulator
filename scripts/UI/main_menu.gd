extends Control
class_name MainMenu

@export var level_selection_buttons: Array[Button]
var button_group: ButtonGroup = ButtonGroup.new()

func _ready() -> void:
	for button in level_selection_buttons:
		button.button_group = button_group
		button.toggle_mode = true
	
	#select_level(1)
	level_selection_buttons[0].button_pressed = true

func _on_play_game_button_pressed() -> void:
	for i in range(level_selection_buttons.size()):
		if level_selection_buttons[i].button_pressed:
			GM.current_level_number = i + 1
	get_tree().change_scene_to_file("res://scenes/menus/game.tscn")

@onready var buttons:HBoxContainer = $MarginContainer/VBoxContainer/Buttons

#func _on_level_1_pressed() -> void:
	#select_level(1)
#
#func _on_level_2_pressed() -> void:
	#select_level(2)
#
#func _on_level_3_pressed() -> void:
	#select_level(3)
#
#func select_level(level_number: int) -> void:
	#print(level_number)
	#for i in range(len(level_selection_buttons)):
		#var button = level_selection_buttons[i]
		#print("button ", level_number, button.button_pressed)
		#if i == level_number + 1:
			#button.set_pressed_no_signal(true)
		#else:
			#button.set_pressed_no_signal(false)
			#
	##buttons.get_children()[level_number-1].text = '[Selected] Level %d' % (level_number)
	#GM.current_level_number = level_number
