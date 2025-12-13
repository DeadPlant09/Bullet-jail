extends Control

# @export variables
@export var start_game: bool

# variables
@onready var title_label: Label = $VBoxContainer/title_label
@onready var start_button: Button = $VBoxContainer/start
@onready var retry_button: Button = $VBoxContainer/retry
@onready var quit_button: Button = $VBoxContainer/quit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# functons
func _ready() -> void:
	start_button.grab_focus()
	
	if not Global.game_runing: Global.game_runing = start_game
	else: hide()
	
	retry_button.hide()
	
	start_button.button_up.connect(start)
	retry_button.button_up.connect(restart)
	quit_button.button_up.connect(quit)
	
	Global.Game_Over.connect(try_again)
	Global.Deleted_Save.connect(Show_Deleted_Message)


func start():
	Global.game_runing = true
	hide()

func restart():
	Global.game_runing = true # so it start up automaticlly
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()


func try_again():
	title_label.text = "GAME OVER"
	start_button.hide()
	retry_button.show()
	show()
	retry_button.grab_focus()

func Show_Deleted_Message():
	animation_player.play("show deleted message")
