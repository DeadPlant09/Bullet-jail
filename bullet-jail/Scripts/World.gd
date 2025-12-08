extends Node2D

# export variables
@export var start_spawn = true

# variables
@onready var ui: Node = $UI
@onready var start_menu: Control = $"UI/Start Menu"
@onready var spawner: spawner_component = $UI/spawner_component
@onready var spawn_timer: Timer = $"UI/spawn timer"
@onready var health_label: Label = $"UI/Health Label"
@onready var score_label: Label = $"UI/Score Label"


# functions
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_random_bullet)
	Global.Collected_Money.connect(update_score)

func spawn_random_bullet():
	if not Global.game_runing or not start_spawn: return
	Spawn_normal_car()


func Spawn_normal_car():
	var marker = randi_range(1, 6)
	var marker_index = marker - 1 # the first index in godot is 0  which makes all the index one less the amunount 
	 
	#print(ui.get_child(marker_index).name)
	
	spawner.scene = load("res://Scenes/car_(normal).tscn")
	
	spawner.Spawn(ui.get_child(marker_index).position)
	
	var instance = spawner.instance
	var instance_move_component = instance.get_child(2)
	
	instance_move_component.velocity = Vector2(-320, 0)
	
	if Global.in_range(marker_index, 3, 5):
		instance.rotation_degrees = 90.0 
		instance_move_component.velocity = Vector2(0, -290)


func update_score():
	score_label.text = str(Global.money)
	
	if Global.high_score >= Global.money: return
	
	score_label.text = str(Global.money) + "HIGH SCORE!!!"
	score_label.modulate = Color.YELLOW
