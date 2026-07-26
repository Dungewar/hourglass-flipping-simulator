extends Node2D
class_name Minigame

var hourglass: Hourglass

var retry_popup = preload("res://scenes/retry_popup.tscn").instantiate()
var victory_popup = preload("res://scenes/victory_popup.tscn").instantiate()
var is_popup_showing: bool = false

func _ready():
	add_child(retry_popup)
	add_child(victory_popup)
	retry_popup.hide()
	victory_popup.hide()
	
	# connect button signals
	var loss_button: Button = $RetryPopup/MarginContainer/VBoxContainer/LossButton
	var victory_button: Button = $VictoryPopup/VBoxContainer/VictoryButton
	loss_button.pressed.connect(_on_loss_button_pressed)
	victory_button.pressed.connect(finish_minigame)

func set_params(_params: Dictionary):
	pass

func retry_minigame():
	pass

func finish_minigame():
	GM.hourglass_manager.remove_hourglass(hourglass)
	GM.minigame_viewer.close_current_minigame()
	queue_free()

# POPUP STUFF
func show_victory_popup():
	if is_popup_showing:
		return
	is_popup_showing = true
	victory_popup.show()

func show_retry_popup():
	if is_popup_showing:
		return
	is_popup_showing = true
	retry_popup.show()
	retry_popup.z_index = 102

func _on_loss_button_pressed():
	retry_popup.hide()
	retry_minigame()
	is_popup_showing = false
