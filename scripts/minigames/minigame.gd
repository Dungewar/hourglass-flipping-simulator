extends Node2D
class_name Minigame

@onready var close_button:Button = $CloseButton
@onready var background:Sprite2D = $Background
var event: MinigameEvent

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_button_pressed() -> void:
	is_open = false
