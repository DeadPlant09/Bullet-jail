extends Area2D
class_name Area_Caller

@export var debug:bool
@export var node:Node2D
@export var responce:String


func Hazard_Colided(area: Area2D) -> void:
	if debug: print(area.name)
	node.call(responce)
