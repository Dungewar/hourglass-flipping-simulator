extends Node

var LEVEL_PLANS: Array[LevelPlanner.LevelPlan] = LevelPlanner.new().get_global_level_plans()
var current_level_number: int

var hourglass_manager: HourglassManager
var game_player: GamePlayer
var minigame_viewer: MinigameViewer
