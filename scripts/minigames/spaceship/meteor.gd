extends CharacterBody2D
class_name Meteor

var initial_velocity: Vector2
var spaceship_minigame: SpaceshipMinigame
@export var max_drift: float = 100
@export var minimum_velocity: float = 200
@export var maximum_velocity: float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var initial_velocity_y = ((2*randf()-1)**3 / 2 + 0.5) * (maximum_velocity - minimum_velocity) + minimum_velocity
	var initial_velocity_x = (randf()-0.5) * 2 * max_drift
	initial_velocity = Vector2(initial_velocity_x, initial_velocity_y)
	#print("Spawned meteor of velocity: ", initial_velocity)
	
	# maybe temporary
	velocity = initial_velocity

func _physics_process(_delta: float) -> void:
	move_and_slide()
	#var collision: KinematicCollision2D move_and_collide(initial_velocity)
	var collision = get_last_slide_collision()
	
	if collision and collision.get_collider() is Spaceship:
		#print("We got him bois")
		spaceship_minigame.meteor_hit()
	#elif collision:
		#print("We struck ", collision.get_collider())
