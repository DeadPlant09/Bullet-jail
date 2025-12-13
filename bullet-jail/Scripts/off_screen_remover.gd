extends VisibleOnScreenNotifier2D
class_name off_screen_remover

func _ready() -> void:
	Global.Unlock_Dash.connect(Unlocking_Dash)

func _on_screen_exited() -> void:
	get_parent().queue_free()

func Unlocking_Dash():
	get_parent().queue_free()
