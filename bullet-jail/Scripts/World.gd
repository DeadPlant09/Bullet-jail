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
@onready var hanbox: CharacterBody2D = $"Hanbox (player)"


# functions
func _ready() -> void:
	health_label.text = "HP: " + str(hanbox.hp)
	
	var spawn_time = 1.5  / (0.5 - (Global.money * 0.01)) # decreces as money grows
	
	spawn_timer.start(spawn_time)
	
	Global.Collected_Money.connect(Update_score)
	hanbox.update_health_bar.connect(Update_Health_Bar)
	spawn_timer.timeout.connect(Spawn_Random_Bullet)


func Spawn_Random_Bullet():
	if not Global.game_runing or not start_spawn: return
	var Bullet_number = randi_range(1,6)
	
	if Bullet_number == 1:
		Spawn_Normal_Car()
		
	elif Bullet_number >= 2 and Global.money >= 10: Spawn_Drifiter_Car()
		
	else: Spawn_Normal_Car() # if all else fails


func Spawn_Normal_Car():
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
	var marker = randi_range(7, 12)
	var marker_index = marker - 1 # the first index in godot is 0  which makes all the index one less the amunount 
	 
	#print(ui.get_child(marker_index).name)
	
	spawner.scene = load("res://Scenes/car_(drifiter).tscn")
	
	spawner.Spawn(ui.get_child(marker_index).position)
	
	var instance = spawner.instance
	var instance_move_component = instance.get_child(2)
	
	instance_move_component.velocity = Vector2(350, 0)
	
	if Global.in_range(marker_index, 10, 11):
		instance.rotation_degrees = 90.0 
		instance_move_component.velocity = Vector2(0, 320)
	
	instance.Chose_Directon() # to change direction AFTER you have movementn


func Update_Health_Bar(health:int):
	print("HP: " + str(health))
	health_label.text = "HP: " + str(health)

func Update_score():
	score_label.text = str(Global.money)
	
	if Global.high_score >= Global.money: return
	
	score_label.text = str(Global.money) + "HIGH SCORE!!!"
	score_label.modulate = Color.YELLOW
