extends Node2D

# variables
@onready var ui: Node = $UI
@onready var start_menu: Control = ui.get_child(0)
@onready var spawner: spawner_component = ui.get_child(1)
@onready var spawn_timer: Timer = $"UI/spawn timer"

# functions
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_random_bullet)


func in_range(variable:int, greater_than:int, less_than:int)  -> bool:
	if not greater_than <= variable:
		print("greater_than")
		return false
	
	if not variable <= less_than:
		print("less_than")
		return false
	
	return true


func spawn_random_bullet():
	if not Global.game_runing: return
	Spawn_normal_car()


func Spawn_normal_car():
	var marker = randi_range(2, 4)
	print(ui.get_child(marker).name)
	
	spawner.scene = load("res://Scenes/car_(normal).tscn")
	
	spawner.Spawn(ui.get_child(marker).position)
	
	var instance_move_component = spawner.instance.get_child(2)
	
	if in_range(marker, 2, 4):
		instance_move_component.velocity = Vector2(-250, 0)
	else:
		instance_move_component.velocity = Vector2(0, -230)
	
