extends CharacterBody2D

# export variables
@export var debug:bool

# variables
var HP:int
var speed = 300

func _ready() -> void:
	Start()

func _process(_delta: float) -> void:
	 
	if not Global.game_runing: return
	
	var player_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = player_input * speed
	
	if debug: print(player_input)
	
	move_and_slide()

func Start():
	$ColorRect.color = Color.SADDLE_BROWN
	HP = 3


func Got_Hit(): # you died
	$ColorRect.color = Color.WHITE
	Global.Game_Over.emit()
