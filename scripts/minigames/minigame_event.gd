extends Event
class_name MinigameEvent

var minigame_scene: PackedScene = preload("res://objects/minigame.tscn")
var minigame: Minigame
@export var minigame_list: Array[Minigame] = []

func _ready() -> void:
	pass

func trigger():
	super()
	minigame = minigame_scene.instantiate()
	var hourglass:Hourglass = GM.hourglass_spawner.add_hourglass()
	hourglass.init_minigame_event(self)

func complete(is_successful: bool = true):
	if is_successful:
		pass
	else:
		GM.game_player.hourglass_failed()
	super(is_successful)
