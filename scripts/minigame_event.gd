extends Event
class_name MinigameEvent

var minigame: Minigame
@export var minigame_list: Array[Minigame] = []

func _ready() -> void:
	pass

func trigger():
	super()
	minigame = Minigame.new()
	GM.houglass_spawner.add_hourglass(self)

func complete(is_successful: bool = true):
	if is_successful:
		pass
	else:
		GM.game_player.hourglass_failed()
	super(is_successful)
