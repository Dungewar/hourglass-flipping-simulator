extends Node
class_name GamePlayer

#var _buffer: Countdown = Countdown.new()
var time_since_start: float = 0
@export var event_interval: float = 10
var last_event_time: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_start += delta
	if last_event_time + event_interval > time_since_start:
		last_event_time = time_since_start
		# trigger random event
