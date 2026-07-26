extends Control
class_name MinigameViewer

@onready var sub_viewport:SubViewport = $MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/SubViewportContainer/SubViewport
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

func _ready() -> void:
	is_open = false
	GM.minigame_viewer = self

func _process(_delta):
	pass

func open_minigame(minigame_to_open: Minigame) -> void:
	minigame = minigame_to_open
	sub_viewport.add_child(minigame)
	is_open = true

func close_current_minigame() -> bool:
	if sub_viewport.get_children().has(minigame):
		sub_viewport.remove_child(minigame)
		minigame = null
		is_open = false
		return true
	return false

func _on_close_button_pressed() -> void:
	close_current_minigame()
