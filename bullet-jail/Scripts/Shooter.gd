extends Node2D

@onready var move: move_component = $move_component
@onready var bullet_timer: Timer = $"bullet timer"
@onready var bullet_spawner: spawner_component = $"bullet spawner"
@onready var gun: Node2D = $gun
@onready var bullet_marker: Marker2D = $"gun/bullet marker"

func Cheak_Direction() -> void:
	var if_moving_left = move.velocity.x < 0
	if if_moving_left:  gun.rotation_degrees = 180.0
	bullet_timer.timeout.connect(Shoot)

func Shoot():
	bullet_spawner.Spawn(bullet_marker.global_position)
	bullet_spawner.instance.velocity.y = -move.velocity.x
	
