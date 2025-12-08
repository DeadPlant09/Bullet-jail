extends VisibleOnScreenNotifier2D
class_name off_screen_remover


func _on_screen_exited() -> void:
	print(get_parent().name + " delete")
	queue_free()
