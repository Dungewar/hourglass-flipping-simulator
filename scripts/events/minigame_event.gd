extends Event
class_name MinigameEvent

var minigame_scene: PackedScene = preload("res://objects/minigame.tscn")
var collect_cheese_minigame_scene: PackedScene = preload("res://objects/collect_cheese/collect_cheese_minigame.tscn")
var minigame: Minigame
@export var minigame_list: Array[Minigame] = []

func _ready() -> void:
	pass

func trigger():
	super()
	minigame = collect_cheese_minigame_scene.instantiate()
	minigame.event = self
	var hourglass:Hourglass = GM.hourglass_spawner.add_hourglass()
	hourglass.init_minigame_event(self)

func complete(is_successful: bool = true):
	if is_successful:
		pass
	else:
		GM.game_player.hourglass_failed()
	minigame.queue_free()
	super(is_successful)
