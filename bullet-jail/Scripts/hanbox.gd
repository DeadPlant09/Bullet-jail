extends CharacterBody2D

# signals
signal update_health_bar(health: int)

# export variables
@export var debug:bool

# variables
@onready var animations: AnimationPlayer = $Animation
@onready var dash_paricles: GPUParticles2D = $paricles
@onready var invincablity_timer: Timer = $"Invincablity Timer"
const max_hp = 3
var hp:int:
	set(value):
		hp = value
		emit_signal("update_health_bar", hp)
var speed = 300
var dashed = false

func _ready() -> void:
	Start()

func _process(_delta: float) -> void:
	if not Global.game_runing: return
	
	var player_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = player_input * speed
	
	if debug: print(player_input)
	
	move_and_slide()

func Start():
	hp = max_hp 


func _input(_event: InputEvent) -> void:
	var dash_button_pressed = Global.unlocked_dash and Input.is_action_just_pressed("ui_accept") 
	
	var is_moving = not velocity == Vector2.ZERO and not hp == 0
	
	if dash_button_pressed and is_moving:
		Dash()


func Dash():
	if dashed: return
	
	speed *= 2.2
	invincablity_timer.start(0.25)
	animations.play("Dash")
	dash_paricles.emitting = true
	dashed = true
	
	await invincablity_timer.timeout
	
	dash_paricles.emitting = false
	animations.play("RESET")
	speed = 300
	
	var dash_cooldown = get_tree().create_timer(0.35).timeout
	await dash_cooldown
	
	dashed = false


func Got_Hit():
	
	var invincablity_on = not invincablity_timer.is_stopped()
	
	if invincablity_on: return
	
	hp -= 1
	invincablity_timer.start(0.7)
	animations.play("blinking")
	
	var dead = hp == 0
	
	if not dead: return
	
	Global.Game_Over.emit()
