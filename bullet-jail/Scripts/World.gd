extends Node2D

# export variables
@export var start_spawn = true

# variables
@onready var ui: Node = $UI
@onready var start_menu: Control = $"UI/Start Menu"
@onready var spawner: spawner_component = $UI/spawner_component
@onready var car_timer: Timer = $"UI/car timer"
@onready var drifter_timer: Timer = $"UI/drifter timer"
@onready var shooter_timer: Timer = $"UI/shooter timer"
@onready var lazer_timer: Timer = $"UI/lazer timer"
@onready var bomb_timer: Timer = $"UI/bomb timer"
@onready var cage_timer: Timer = $"UI/cage timer"
@onready var health_label: Label = $"UI/Health Label"
@onready var score_label: Label = $"UI/Score Label"
@onready var hanbox: CharacterBody2D = $"Hanbox (player)"


# functions
func _ready() -> void:
	health_label.text = "HP: " + str(hanbox.hp)
	
	# start timers
	car_timer.start(1.5  / (0.5 - (Global.money * 0.01))) # decreces as money grows
	drifter_timer.start(2.0  / (0.5 - (Global.money * 0.01)))
	shooter_timer.start(2.5  / (0.5 - (Global.money * 0.01)))
	
	# UI updates
	Global.Collected_Money.connect(Update_Score)
	hanbox.update_health_bar.connect(Update_Health_Bar)
	
	# Hazard Spawn
	Global.Unlock_Dash.connect(Get_Dash)
	car_timer.timeout.connect(Spawn_Normal_Car)
	drifter_timer.timeout.connect(Spawn_Drifiter_Car)
	shooter_timer.timeout.connect(Spawn_Shooter_Car)
	


func Update_Health_Bar(health:int):
	print("HP: " + str(health))
	health_label.text = "HP: " + str(health)

func Update_Score():
	score_label.text = str(Global.money)
	
	if Global.high_score >= Global.money: return
	
	score_label.text = str(Global.money) + " HIGH SCORE!!!"
	score_label.modulate = Color.YELLOW


func Update_Spawning():
	if Global.money >= 101: return
	elif Global.money >= 30: lazer_timer.start(5.0  / (0.5 - (Global.money * 0.01)))
	elif Global.money >= 55: bomb_timer.start(3.5  / (0.5 - (Global.money * 0.01)))
	elif Global.money >= 100: cage_timer.start(4.0  / (0.5 - (Global.money * 0.01)))

func Get_Dash():
	start_spawn = false

func Spawn_Normal_Car():
	if not start_spawn or not Global.game_runing: return
	
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

func Spawn_Drifiter_Car():
	if not start_spawn or not Global.game_runing: return
	if not Global.money >= 10: return
	
	var marker = randi_range(7, 12)
	var marker_index = marker - 1 # the first index in godot is 0  which makes all the index one less the amunount 
	
	spawner.scene = load("res://Scenes/car_(drifiter).tscn")
	
	spawner.Spawn(ui.get_child(marker_index).position)
	
	var instance = spawner.instance
	var instance_move_component = instance.get_child(2)
	
	instance_move_component.velocity = Vector2(350, 0)
	
	if Global.in_range(marker_index, 10, 11):
		instance.rotation_degrees = 90.0 
		instance_move_component.velocity = Vector2(0, 320)
	
	instance.Chose_Directon() # to change direction AFTER you have movement

func Spawn_Shooter_Car():
	if not start_spawn or not Global.game_runing: return
	if not Global.money >= 20: return
	
	var spawn_markers = [1,13]
	var marker = spawn_markers.pick_random()
	var marker_index = marker - 1 # the first index in godot is 0  which makes all the index one less the amunount 
	
	spawner.scene = load("res://Scenes/car_(shooter).tscn")
	
	spawner.Spawn(ui.get_child(marker_index).position)
	
	var instance = spawner.instance
	var instance_move_component = instance.get_child(2)
	
	instance_move_component.velocity = Vector2(-330, 0)
	
	if marker_index == 8: instance_move_component.velocity = Vector2(350, 0)
	
	instance.Cheak_Direction()
