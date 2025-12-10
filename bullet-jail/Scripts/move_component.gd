extends Node2D
class_name move_component

# @export variables
@export var debug: bool
@export var velocity: Vector2:
	set(value):
		velocity = value
		print("value")
@export var moving:Node2D

# variables

# functons

func _process(delta: float) -> void:
	moving.global_position += velocity * delta
	if debug: print(moving.position)
