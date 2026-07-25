extends Area2D
class_name Hourglass

static var DEFAULT_TIME:int = 0
var current_time:float = max_time
var max_time:float = 15
var is_being_held: bool = false
var hold_duration: float = 0
var last_good_rotation: float = 0

var target_rotation: float = 0.0
var broken:bool = false
var is_button_visible:bool:
	set(value):
		is_button_visible = value
		
		if is_button_visible:
			minigame_button.show()
		else:
			minigame_button.hide()
		
@onready var hourglass_sprite:Sprite2D = $HourglassSprite
@onready var label:Label = $Label
@onready var minigame_button:Button = $MinigameButton
@export var required_holding_time: float = 3
var minigame: Minigame

func _ready() -> void:
	is_button_visible = false

func init(minigame1: Minigame=null, position1: Vector2=Vector2(100,100)):
	minigame = minigame1
	position = position1

func _on_minigame_button_pressed() -> void:
	GM.minigame_viewer.open_minigame(minigame)

func _process(delta: float) -> void:
	if not broken:
		current_time += -cos(fmod(hourglass_sprite.rotation, PI))*delta
		if current_time <= 0: # Broken
			# trigger_hourglass_breaking()
			broken = true
			GM.game_player.hourglass_broke(self)
	label.text = get_text()
	
	if is_being_held:
		hold_duration += delta
		target_rotation += PI * delta / required_holding_time
		create_tween().tween_property(hourglass_sprite, "rotation", target_rotation, delta).set_trans(Tween.TRANS_QUART)
		
		if hold_duration > required_holding_time:
			last_good_rotation = snappedf(hourglass_sprite.rotation, PI)
			print(last_good_rotation)
			current_time = max_time - current_time
			hold_duration = 0

func get_text() -> String:
	if broken:
		return "Broken"
	return str(snappedf(current_time, 0.1))

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_being_held = true
			elif event.is_released():
				is_being_held = false
				create_tween().tween_property(hourglass_sprite, "rotation", last_good_rotation, 0.25).set_trans(Tween.TRANS_QUART)
				target_rotation = last_good_rotation
				hold_duration = 0
