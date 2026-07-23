extends Area2D
class_name Hourglass

static var DEFAULT_TIME:int = 0;

var target_rotation: float = 0.0
var max_time:float;
var current_time:float;
var broken:bool = false;
@onready var hourglass_sprite:Sprite2D = $HourglassSprite
@onready var label:Label = $Label

func _init(t: int = 15) -> void:
	max_time = t;
	current_time = t;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
