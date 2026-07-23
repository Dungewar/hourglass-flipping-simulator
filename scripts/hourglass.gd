extends Area2D
class_name Hourglass

var target_rotation: float = 0.0
var max_time:float = 15;
var current_time:float = max_time;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time -= delta
	print(get_time())

func get_time() -> String:
	return str(snappedf(current_time, 0.1)  	)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			_flip()
			current_time = max_time - current_time

func _flip() -> void:
	target_rotation += PI
	create_tween().tween_property(self, "rotation", target_rotation, 0.25).set_trans(Tween.TRANS_QUART)
