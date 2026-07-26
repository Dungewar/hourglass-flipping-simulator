extends Area2D
class_name Hourglass

@onready var hourglass_sprite:Sprite2D = $HourglassSprite
@onready var label:Label = $Label
@onready var minigame_button:Button = $MinigameButton

# time and rotation stuff
@export var required_holding_time: float = 3
static var DEFAULT_TIME:int = 0
var max_time:float = 30:
	set(value):
		max_time = value
		current_time = max_time
var current_time:float = max_time
var hold_duration: float = 0
var last_good_rotation: float = 0
var is_being_held: bool = false
var target_rotation: float = 0.0

var working:bool = true

var minigame: Minigame

var is_button_visible:bool:
	set(value):
		is_button_visible = value
		if is_button_visible:
			minigame_button.show()
		else:
			minigame_button.hide()

func _ready() -> void:
	pass

func _on_minigame_button_pressed() -> void:
	GM.minigame_viewer.open_minigame(minigame)

func _process(delta: float) -> void:
	if working:
		current_time += -cos(fmod(hourglass_sprite.rotation, PI))*delta
		if current_time < 0: # Broken
			working = false
			GM.hourglass_manager.remove_hourglass(self)
			GM.game_player.on_hourglass_broke()
	label.text = get_text()
	
	if is_being_held and there_are_no_rocks_on_top():
		hold_duration += delta
		target_rotation += PI * delta / required_holding_time
		create_tween().tween_property(hourglass_sprite, "rotation", target_rotation, delta).set_trans(Tween.TRANS_QUART)
		
		if hold_duration > required_holding_time:
			last_good_rotation = snappedf(hourglass_sprite.rotation, PI)
			print(last_good_rotation)
			current_time = max_time - current_time
			hold_duration = 0

func get_text() -> String:
	if not working:
		return "Broken"
	return str(snappedf(current_time, 0.1))


func there_are_no_rocks_on_top() -> bool:
	for child in get_children():
		if child is Rock:
			return false
	return true

# Removes 1 rock, gives true if it removed a rock
func remove_rock() -> bool:
	for child in get_children():
		if child is Rock:
			child.queue_free()
			return true
	return false

func _on_flipping_button_button_down() -> void:
	is_being_held = true


func _on_flipping_button_button_up() -> void:
	is_being_held = false
	create_tween().tween_property(hourglass_sprite, "rotation", last_good_rotation, 0.25).set_trans(Tween.TRANS_QUART)
	target_rotation = last_good_rotation
	hold_duration = 0
