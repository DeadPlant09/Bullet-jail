extends VisibleOnScreenNotifier2D
class_name off_screen_remover

func _ready() -> void:
	print("ready")
	Global.Unlock_Dash.connect(Unlocking_Dash)

func _on_screen_exited() -> void:
	print("delete")
	queue_free()

func Unlocking_Dash():
	print("delete")
	queue_free()
