extends Node2D

# variables
@onready var ui: Node = $UI
@onready var start_menu: Control = $"UI/Start Menu"
@onready var spawner: spawner_component = $UI/spawner_component
@onready var spawn_timer: Timer = $"UI/spawn timer"

# functions
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_random_bullet)

func spawn_random_bullet():
	if not Global.game_runing: return
	Spawn_normal_car()

func in_range(variable:int, greater_than:int, less_than:int)  -> bool:
	assert(not greater_than >= less_than, "World: the Minimum value is more than or epual to the Max value" + str(less_than))
	
	if not greater_than <= variable:
		print("greater_than")
		return false
	
	if not variable <= less_than:
		print("less_than")
		return false
	
	return true

func Spawn_normal_car():
	var marker = randi_range(1, 6)
	var marker_index = marker - 1 # the first index in godot is 0  which makes all the index one less the amunount 
	 
	print(ui.get_child(marker_index).name)
	
	spawner.scene = load("res://Scenes/car_(normal).tscn")
	
	spawner.Spawn(ui.get_child(marker_index).position)
	
	var instance = spawner.instance
	var instance_move_component = instance.get_child(2)
	
	instance_move_component.velocity = Vector2(-250, 0)
	
	if in_range(marker_index, 3, 5):
		instance.rotation_degrees = 90.0 
		instance_move_component.velocity = Vector2(0, -230)
	
	Global.score += 1
