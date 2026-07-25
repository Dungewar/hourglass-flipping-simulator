extends Area2D
class_name Hourglass

static var DEFAULT_TIME:int = 0

var target_rotation: float = 0.0
var max_time:float = 15
var current_time:float = max_time
var broken:bool = false
var is_being_held: bool = false
var hold_duration: float = 0
var last_good_rotation: float = 0
var is_button_visible:bool:
	set(value):
		is_button_visible = value
		
		if is_button_visible:
			minigame_button.show()
		else:
			minigame_button.hide()
		

var minigame_event: MinigameEvent
@onready var hourglass_sprite:Sprite2D = $HourglassSprite
@onready var label:Label = $Label
@onready var minigame_button:Button = $MinigameButton
@export var required_holding_time: float = 3

#func _init(t: int = 15, show_button: bool = true) -> void:
	#max_time = t;
	#current_time = t;
	#self.is_button_visible = show_button
#
#func set_button_visibility(visible: bool) -> void:
	#is_button_visible = visible
	#if visible:
		#minigame_button.show()
	#else:
		#minigame_button.hide()

func init_minigame_event(minigame_event: MinigameEvent):
	self.minigame_event = minigame_event
	is_button_visible = true
	GM.add_child(minigame_event.minigame)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_button_visible = false
	minigame_button.connect("button_up", _button_pressed)

func _button_pressed():
	minigame_event.minigame.open_minigame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not broken:
		current_time -= delta
		if current_time <= 0 or current_time >= 15: # Broken
			# trigger_hourglass_breaking()
			broken = true
			GM.game_player.hourglass_broke(self)
	label.text = get_text()
	
	if is_being_held:
		hold_duration += delta
		target_rotation += PI * delta / required_holding_time
		create_tween().tween_property(hourglass_sprite, "rotation", target_rotation, delta).set_trans(Tween.TRANS_QUART)
		
		if hold_duration > required_holding_time:
			last_good_rotation = hourglass_sprite.rotation
			print(last_good_rotation)
			current_time = max_time - current_time
			hold_duration = 0
			
	elif hold_duration > 0:
		create_tween().tween_property(hourglass_sprite, "rotation", last_good_rotation, 0.25).set_trans(Tween.TRANS_QUART)
		hold_duration = 0

func get_text() -> String:
	if broken:
		return "Broken"
	return str(snappedf(current_time, 0.1))

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_being_held = true
			elif event.is_released():
				is_being_held = false
