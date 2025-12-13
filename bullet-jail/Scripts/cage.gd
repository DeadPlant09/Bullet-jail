extends Node2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var lift_timer: Timer = $"lift timer"
@onready var static_body: StaticBody2D = $StaticBody2D


func Drop_Cage() -> void:
	animation.play("cage_incoming")
	
	await animation.animation_finished
	
	animation.play("drop_cage")
	lift_timer.start()
	
	await lift_timer.timeout
	
	animation.play("lift_cage")


func Disable_Coilison():
	for child in static_body.get_children():
		child.disabled = true

func Enable_Coilison():
	for child in static_body.get_children():
		child.disabled = false
