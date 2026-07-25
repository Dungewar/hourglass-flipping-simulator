extends Minigame
class_name SpaceshipMinigame

@export var meteor_count: int = 20
@export var meteor_spawn_interval: float = 0.1
@export var post_meteor_timer_until_win: float = 5
@export var victory_screen: Control
@export var loss_screen: Control
@export var meteor_count_label: Label
var can_win: bool = true
var meteor_scene: Resource = preload("res://scenes/minigames/spaceship/meteor.tscn")
var meteors_spawned: int = 0
var time_since_meteor_spawn: float = 0


func meteor_hit():
	loss_screen.show()
	can_win = false

func spawn_meteor():
	var meteor: Meteor = meteor_scene.instantiate()
	meteor.spaceship_minigame = self
	
	var camera_size = get_viewport().get_visible_rect().size
	camera_size.x += 200
	var camera_position = get_viewport().get_visible_rect().position - camera_size/2
	meteor.position = randf() * camera_size + camera_position
	meteor.position.y -= camera_size.y
	print(meteor.position)
	add_child(meteor)
	#meteor.position = Vector2(0,0)


func _process(_delta: float) -> void:
	time_since_meteor_spawn += _delta
	meteor_count_label.text = "Meteors left: " + str(meteor_count - meteors_spawned)
	
	if meteors_spawned < meteor_count:
		if time_since_meteor_spawn > meteor_spawn_interval:
			print(time_since_meteor_spawn, meteor_spawn_interval)
			spawn_meteor()
			time_since_meteor_spawn = 0
			meteors_spawned += 1
			print("Spawned meteor!")
			
	elif time_since_meteor_spawn > post_meteor_timer_until_win and can_win:
		# you win!
		victory_screen.show()


func _on_victory_button_pressed() -> void:
	finish()


func _on_loss_button_pressed() -> void:
	can_win = true
	#retry_minigame()
	meteors_spawned = 0
	time_since_meteor_spawn = -3
	for child in get_children():
		if child is Meteor:
			child.queue_free()
	loss_screen.hide()
