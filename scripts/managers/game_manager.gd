extends Node
var hourglass_manager: HourglassManager
var game_player: GamePlayer

var minigame_viewer_scene: PackedScene = preload("res://scenes/minigames/minigame_viewer.tscn")
var minigame_viewer: MinigameViewer = minigame_viewer_scene.instantiate()
