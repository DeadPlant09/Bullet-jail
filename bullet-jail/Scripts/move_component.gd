extends Node2D
class_name move_component

# @export variables
@export var debug: bool
@export var velocity: Vector2
@export var moving:Node2D

# variables

# functons

func _process(delta: float) -> void:
	moving.position += velocity * delta
	if debug: print(moving.position)
