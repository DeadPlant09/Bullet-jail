extends Node
class_name spawner_component

# @export variables
@export var scene: PackedScene
@export var position: Vector2

# variables
var instance

# functons
func Spawn(position:Vector2, parent: Node2D = get_tree().current_scene):
	# custom error will be emit if ttheres only the default packedscene resource 
	assert(scene is PackedScene, get_parent().name + ": no assigned scene")
	print("spawn")
	# instance scene
	instance = scene.instantiate()
	
	# set instance
	parent.add_child(instance)
	instance.global_position = position
	
	# function finished
	return instance
