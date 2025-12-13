extends Node2D

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.body_entered.connect(Give_Dash)

func Give_Dash(_area):
	Global.unlocked_dash = true
	Global.Unlocked_Dash.emit()
	queue_free()
