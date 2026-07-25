extends Control
class_name MinigameViewer

@onready var sub_viewport_container:SubViewportContainer = $MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/SubViewportContainer
var minigame: Minigame = null

var is_open:bool = false:
	set(value):
		is_open = value
		if is_open:
			z_index = 100
			self.show()
		else:
			self.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_open = false
	GM.minigame_viewer = self

func open_minigame(minigame1: Minigame) -> void:
	minigame = minigame1
	sub_viewport_container.add_child(minigame)

func _on_close_button_pressed() -> void:
	sub_viewport_container.remove_child(minigame)
	minigame = null
	is_open = false
