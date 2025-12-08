extends Area2D
class_name Dollar

@export var amount:int

@onready var amount_label: Label = $"amount label"

func _ready() -> void:
	amount_label.text = str(amount)

func Dollar_Collected(body: Node2D):
	Global.money += amount
	queue_free()
