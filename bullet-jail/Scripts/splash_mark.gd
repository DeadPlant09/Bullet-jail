extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(Load_Game)
	animation_player.play("fade in and out")

func Load_Game(_animation_name:String):
	var world = load("res://Scenes/World.tscn")
	get_tree().change_scene_to_packed(world)
	
