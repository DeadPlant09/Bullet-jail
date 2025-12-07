extends Control

# @export variables
@export var start_game: bool

# variables
@onready var start: Button = $VBoxContainer/start
@onready var retry: Button = $VBoxContainer/retry
@onready var quit: Button = $VBoxContainer/quit

# functons
func _ready() -> void:
	Global.game_runing = start_game
	if Global.game_runing: hide()
	
	start.button_up.connect(Start_Game)
	retry.button_up.connect(Restart)
	quit.button_up.connect(Quit)


func Start_Game():
	Global.game_runing = true
	hide()

func Restart():
	Global.Save()
	get_tree().reload_current_scene()

func Quit():
	Global.Save()
	get_tree().quit()
