extends Node2D
class_name Minigame

@onready var close_button:Button = $CloseButton
@onready var background:Sprite2D = $Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_minigame():
	z_index = 100
	self.show()

func close_minigame():
	self.hide()

func _on_close_button_pressed() -> void:
	close_minigame()
