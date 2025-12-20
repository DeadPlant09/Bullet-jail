extends Node2D
class_name move_component

# @export variables
@export var debug: bool
@export var flip: bool
@export var velocity: Vector2:
	set(value):
		velocity = value
		if not flip: return
		Check_Direction()
@export var moving:Node2D

# functons

func _process(delta: float) -> void:
	moving.global_position += velocity * delta
	if debug: print(moving.position)

func Check_Direction():
	if velocity.y > 0: # if going down 
		$sprite.flip_v = true
