extends Node
class_name Event

func trigger():
	pass

func complete(_is_successful: bool = true):
	print('event over')
	queue_free() # delete yourself
