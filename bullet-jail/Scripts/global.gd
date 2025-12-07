extends Node

# signals
signal Game_Over

# variables
var game_runing:bool = false
var score:int

func _ready() -> void:
	Game_Over.connect(game_over)

func game_over():
	game_runing = false
	Save()

func Save():
	print("save")
