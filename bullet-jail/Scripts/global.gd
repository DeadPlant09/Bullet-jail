extends Node

# signals
signal Game_Over
signal Collected_Money
signal Unlock_Dash
signal Unlocked_Dash

# variables
var game_runing:bool = true
var money:int: 
	set(value):
		money = value
		Collected_Money.emit()
		if money >= 30 and not unlocked_dash:
			Unlock_Dash.emit()
			unlocked_dash = true
var high_score:int
var unlocked_dash

func _ready() -> void:
	money = 29
	Game_Over.connect(game_over)

func in_range(variable:int, greater_than:int, less_than:int)  -> bool:
	assert(not greater_than >= less_than, "World: the Minimum value is more than or epual to the Max value" + str(less_than))
	
	if not greater_than <= variable:
		return false
	
	if not variable <= less_than:
		return false
	
	return true

func game_over():
	game_runing = false
	Save()

func Save():
	print("save")
