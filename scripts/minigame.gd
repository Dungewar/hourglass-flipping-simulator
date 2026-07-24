extends Node2D
class_name Minigame

@onready var close_button:Button = $CloseButton
@onready var background:Sprite2D = $Background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_button.connect("button_up", close_minigame())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open_minigame():
	self.show()
	for child in self.get_children():
		child.show()

func close_minigame():
	self.hide()
	for child in self.get_children():
		child.hide();
