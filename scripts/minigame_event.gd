extends Event
class_name MinigameEvent

var hourglass_spawner: HourglassSpawner
var minigame: Minigame

func _ready() -> void:
	hourglass_spawner = GM.houglass_spawner
	# Set random minigame

func trigger(game_player: GamePlayer):
	super(game_player)
	
	hourglass_spawner.add_hourglass(self)

func complete(is_successful: bool = true):
	if is_successful:
		pass
	else:
		GM.game_player.hourglass_failed()
	super(is_successful)
