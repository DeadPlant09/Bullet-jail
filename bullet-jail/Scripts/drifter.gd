extends Node2D
class_name Turnner

@onready var move: move_component = $move_component
@onready var turnner: Node2D = $Turnner
@onready var sprite: TextureRect = $sprite

var random_dir = randi_range(1,2)

func Chose_Directon() -> void:
	var moving_right = not move.velocity.x == 0
	var moving_down = not move.velocity.y == 0
	var turn_down_or_left = random_dir == 1
	var turn_up_or_right = random_dir == 2
	
	if moving_right:
		if turn_down_or_left: turnner.rotation_degrees = 90.0 
		elif turn_up_or_right: turnner.rotation_degrees = -90.0 
	
	elif moving_down:
		if turn_down_or_left: turnner.rotation_degrees = 90.0
		elif turn_up_or_right: turnner.rotation_degrees = -90.0
	
	await get_tree().create_timer(randf_range(0.3,1.3)).timeout
	
	Turn_to_direction(moving_right, moving_down)


func Turn_to_direction(moving_right, moving_down):
	match turnner.rotation_degrees:
		90.0:
			if moving_right: Turn(Vector2(0, move.velocity.x)) # going down
			elif moving_down: Turn(Vector2(-move.velocity.y, 0)) # going left
		
		-90.0:
			if moving_right: Turn(Vector2(0, -move.velocity.x)) # going up
			elif moving_down: Turn(Vector2(move.velocity.y, 0)) # going right

func Turn(direction: Vector2):
	move.velocity = direction
	rotation_degrees += turnner.rotation_degrees
	turnner.rotation_degrees = 0.0
