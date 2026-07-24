extends Area2D
class_name Hourglass

static var DEFAULT_TIME:int = 0;

var target_rotation: float = 0.0
var max_time:float;
var current_time:float;
var broken:bool = false;
var _show_button:bool = false
var minigame_event: MinigameEvent
@onready var hourglass_sprite:Sprite2D = $HourglassSprite
@onready var label:Label = $Label
@onready var minigame_button:Button = $MinigameButton

func _init(t: int = 15, show_button: bool = true) -> void:
	print('hello i am an hourglass')
	max_time = t;
	current_time = t;
	self._show_button = show_button

func set_button_visibility(visible: bool) -> void:
	_show_button = visible
	if visible:
		minigame_button.show()
	else:
		minigame_button.hide()

func set_minigame_event(minigame_event: MinigameEvent):
	self.minigame_event = minigame_event

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_button_visibility(_show_button)
	minigame_button.connect("button_up", _button_pressed)

func _button_pressed():
	print('heck you')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not broken:
		current_time -= delta
		broken = current_time <= 0 or current_time >= 15
	label.text = get_text()

func get_text() -> String:
	if broken:
		return "Broken"
	return str(snappedf(current_time, 0.1)  	)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			_flip()
			current_time = max_time - current_time

func _flip() -> void:
	target_rotation += PI
	create_tween().tween_property(hourglass_sprite, "rotation", target_rotation, 0.25).set_trans(Tween.TRANS_QUART)
