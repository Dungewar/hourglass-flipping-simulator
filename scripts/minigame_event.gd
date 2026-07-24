extends Event
class_name MinigameEvent

var hourglass_spawner: HourglassSpawner

func _ready() -> void:
	hourglass_spawner = GM.houglass_spawner

func trigger(game_player: GamePlayer):
	super(game_player)
	
	hourglass_spawner.add_hourglass(true, self)

func complete(is_successful: bool = true):
	if is_successful:
		pass
	else:
		GM.game_player.hourglass_failed()
	super(is_successful)
