extends CharacterBody2D

# signals
signal update_health_bar(health: int)

# export variables
@export var debug:bool

# variables
@onready var invincablity_animation: AnimationPlayer = $"Invincablity Animation"
@onready var invincablity_timer: Timer = $"Invincablity Timer"
const max_hp = 3
var hp:int:
	set(value):
		hp = value
		print("hp change")
		emit_signal("update_health_bar", hp)
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
	hp = max_hp 


func Got_Hit():
	
	var dead = hp == 0
	var invincablity_on = not invincablity_timer.is_stopped()
	
	if invincablity_on: return
	
	hp -= 1
	invincablity_timer.start(0.7)
	invincablity_animation.play("blinking")
	
	
	if not dead: return
	
	$ColorRect.color = Color.WHITE
	Global.Game_Over.emit()
