extends CharacterBody2D
class_name Spaceship

var camera_size: Vector2
var camera_position: Vector2
@export var acceleration_factor: float = 0.5
@export var player_size: float = 60

func _ready():
	camera_size = get_viewport().get_visible_rect().size
	camera_position = get_viewport().get_visible_rect().position - camera_size/2
	
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var acceleration = (get_global_mouse_position() - position) * acceleration_factor
	#velocity = acceleration
	velocity += acceleration * delta
	#print(velocity, acceleration)
	move_and_slide()
	var minimum_bound: Vector2 = camera_position - Vector2(player_size, player_size)
	var maximum_bound: Vector2 = camera_position + camera_size + Vector2(player_size, player_size)
	
	#var is_within: bool = get_viewport().get_visible_rect().has_point(global_position)
	#print("am within:", is_within)
	if global_position.x > maximum_bound.x or global_position.x < minimum_bound.x:
		print("Flipping X")
		position.x *= -1
	if global_position.y > maximum_bound.y or global_position.y < minimum_bound.y:
		print("Flipping Y")
		position.y *= -1
