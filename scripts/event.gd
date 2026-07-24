extends Node
class_name Event

var game_player: GamePlayer = null

func trigger(game_player: GamePlayer):
	self.game_player = game_player

func complete(is_successful: bool = true):
	queue_free() # delete yourself
