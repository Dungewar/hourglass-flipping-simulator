extends CharacterBody2D
class_name FallingObject

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, -600)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity += Vector2(0, 40)
	#print(velocity)
	move_and_slide()
