extends Node2D
class_name pause_component

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and Global.game_runing:
		Pause()

func Pause():
	get_tree().paused = not get_tree().paused
	Global.Pause.emit() 
