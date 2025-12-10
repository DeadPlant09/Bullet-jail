extends Area2D

@export var debug:bool
@export var node:Node2D
@export var responce:String

func when_bullet_hit(area: Area2D) -> void:
	if debug: print(area.name)
	node.call(responce)
