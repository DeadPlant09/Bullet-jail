extends Node2D

# export variables
@export var start_spawn:bool = true

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
@onready var dash_label: Label = $"UI/Dash label"
@onready var hanbox: CharacterBody2D = $"Hanbox (player)"


# functions
func _ready() -> void:
	health_label.text = "HP: " + str(hanbox.hp)
	
	# start timers
	car_timer.start(1.25  / (0.5 + (Global.money * 0.01))) # decreces as money grows
	drifter_timer.start(2.5  / (0.5 + (Global.money * 0.01)))
	shooter_timer.start(3.0  / (0.5 + (Global.money * 0.01)))
	lazer_timer.start(5.0  / (0.5 + (Global.money * 0.01)))
	cage_timer.start(10.0  / (0.5 + (Global.money * 0.01)))
	
	# UI updates
	Global.Collected_Money.connect(Update_Score)
	Global.Game_Over.connect(Show_High_Score)
	hanbox.update_health_bar.connect(Update_Health_Bar)
	
	# Hazard Spawn
	Global.Unlock_Dash.connect(Get_Dash)
	car_timer.timeout.connect(Spawn_Normal_Car)
	drifter_timer.timeout.connect(Spawn_Drifiter_Car)
	shooter_timer.timeout.connect(Spawn_Shooter_Car)
	lazer_timer.timeout.connect(Spawn_Lazer)
	cage_timer.timeout.connect(Spawn_Cage)


func Update_Health_Bar(health:int):
	print("HP: " + str(health))
	health_label.text = "HP: " + str(health)

func Update_Score():
	score_label.text = str(Global.money)
	
	if Global.high_score >= Global.money: return
	
	score_label.text = str(Global.money) + " HIGH SCORE!!!"
	score_label.modulate = Color.YELLOW

func Show_High_Score():
	score_label.text = "HIGH SCORE: " + str(Global.high_score)
	score_label.modulate = Color.GREEN


func Get_Dash():
	start_spawn = false
	spawner.scene = load("res://Scenes/dash_juice.tscn")
	spawner.call_deferred("Spawn", Vector2(320, 360)) # to add a node after money is deleted (not at the same time)
	
	await Global.Unlocked_Dash # wait for play to collect dash juic
	
	dash_label.show()
	start_spawn = true

func _input(_event: InputEvent) -> void:
	if not dash_label.visible: return
	var dash_button_pressed = Input.is_action_just_pressed("ui_accept") 
	if dash_button_pressed: dash_label.hide()

func Spawn_Hazard(enemy_scene: PackedScene, marker: int):
	var marker_index = marker - 1 # the first index in godot is 0  which makes all the index one less the amunount 
	 
	#print(ui.get_child(marker_index).name)
	
	spawner.scene = enemy_scene
	spawner.Spawn(ui.get_child(marker_index).position)
	
	return marker_index

func Move_Hazard(speed1 = Vector2(0,0), speed2 = Vector2(0,0), rotation_condion = false, degrees = 90.0):
	var instance = spawner.instance
	var instance_move_component = instance.get_child(2) # move component
	
	instance_move_component.velocity = speed1
	
	if rotation_condion:
		instance.rotation_degrees = degrees
		instance_move_component.velocity = speed2


func Spawn_Normal_Car():
	if not start_spawn or not Global.game_runing: return
	
	var speed_1 = Vector2(-320, 0)
	var speed_2 = Vector2(0, -320)
	var rand_marker = randi_range(1, 6)
	var spawn_index = Spawn_Hazard(load("res://Scenes/car_(normal).tscn"), rand_marker)
	
	Move_Hazard(speed_1, speed_2, Global.in_range(spawn_index, 3, 5))

func Spawn_Drifiter_Car():
	if not start_spawn or not Global.game_runing: return
	if not Global.money >= 10: return
	
	var speed_1 = Vector2(350, 0)
	var speed_2 = Vector2(0, 320)
	var rand_marker = randi_range(7, 12)
	var spawn_index = Spawn_Hazard(load("res://Scenes/car_(drifiter).tscn"), rand_marker)
	
	Move_Hazard(speed_1, speed_2, Global.in_range(spawn_index, 10, 11))
	
	var hazard = spawner.instance
	
	hazard.Chose_Directon() # to change direction AFTER you have movement

func Spawn_Shooter_Car():
	if not start_spawn or not Global.game_runing: return
	if not Global.money >= 20: return
	
	var speed_1 = Vector2(330, 0)
	var speed_2 = Vector2(-350, 0)
	var rand_marker = [1,12].pick_random()
	
	Spawn_Hazard(load("res://Scenes/car_(shooter).tscn"), rand_marker)
	Move_Hazard(speed_1, speed_2, rand_marker == 1, -360.0) # glitched when seting angles
	
	var hazard = spawner.instance
	
	hazard.Cheak_Direction()

func Spawn_Lazer():
	if not start_spawn or not Global.game_runing: return
	if not Global.money >= 30: return
	
	var speed_1 = Vector2(0, 400)
	var speed_2 = Vector2(-400, 0)
	var rand_marker = [2,13].pick_random()
	
	Spawn_Hazard(load("res://Scenes/lazer.tscn"), rand_marker)
	Move_Hazard(speed_1, speed_2, rand_marker == 2)

func Spawn_Cage():
	if not start_spawn or not Global.game_runing: return
	if not Global.money >= 50: return
	
	var rand_marker = randi_range(14, 16)
	
	Spawn_Hazard(load("res://Scenes/cage.tscn"), rand_marker)
	
	var hazard = spawner.instance
	
	hazard.Drop_Cage() # to change direction AFTER you have movement
