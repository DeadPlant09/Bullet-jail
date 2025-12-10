extends Node2D
class_name Drop_Chance
# depending on the position and the drop chance the car may drop 1 dollar when passing by

# @export variables
@export var debug:bool
@export var drop_range:int
@export var spawner: spawner_component
@export var move_node: move_component 


# variables
var droped = false
var drop_chance = randi_range(1, 100)
var drop_position = randi_range(100, 600)


# function
func _process(delta):
	if drop_chance > drop_range or droped: return
	
	var can_drop_right = move_node.velocity.x > 0 and global_position.x >= drop_position
	var can_drop_left =  move_node.velocity.x < 0 and global_position.x <= drop_position
	var can_drop_up = move_node.velocity.y < 0 and global_position.y <= drop_position
	var can_drop_down = move_node.velocity.y > 0 and global_position.y >= drop_position
	
	var can_drop_horizontal = can_drop_right or can_drop_left
	var can_drop_vertical = can_drop_up or can_drop_down
	
	if can_drop_horizontal:
		Drop()
	
	elif can_drop_vertical:
		Drop()


func Drop():
	print("spawn")
	spawner.Spawn(global_position)
	droped = true
