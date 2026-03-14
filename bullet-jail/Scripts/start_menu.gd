extends Control

# @export variables
@export var start_game: bool

# variables
@onready var bullet_jail_title: Sprite2D = $"Bullet Jail Title"
@onready var game: Label = $"VBoxContainer/Game state label"
@onready var start_button: BaseButton = $VBoxContainer/start
@onready var retry_button: BaseButton = $VBoxContainer/retry
@onready var quit_button: BaseButton = $VBoxContainer/quit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# functons
func _ready() -> void:
	start_button.grab_focus()
	
	if not Global.game_runing: Global.game_runing = start_game
	else: hide()
	
	retry_button.hide()
	
	start_button.button_up.connect(Start)
	retry_button.button_up.connect(Restart)
	quit_button.button_up.connect(Quit)
	
	Global.Game_Over.connect(Try_again)
	Global.Pause.connect(Show_Pause)
	Global.Deleted_Save.connect(Show_Deleted_Message)


func Start():
	Global.game_runing = true
	hide()

func Restart():
	Global.game_runing = true # so it start up automaticlly
	get_tree().reload_current_scene()

func Quit():
	get_tree().quit()

func Try_again():
	game.text = ""
	start_button.hide()
	retry_button.show()
	quit_button.show()
	show()
	retry_button.grab_focus()

func Show_Pause():
	if get_tree().paused:
		game.text = "PAUSED"
		start_button.hide()
		retry_button.hide()
		quit_button.hide()
		show()
	
	elif not get_tree().paused:
		hide()

func Show_Deleted_Message():
	animation_player.play("show deleted message")
