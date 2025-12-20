extends Node

# signals
signal Game_Over
signal Pause
signal Collected_Money
signal Unlock_Dash
signal Unlocked_Dash
signal Deleted_Save

# variables
const Save_path = "user://Bullet_Jail.cfg"
var config = ConfigFile.new()
var game_runing:bool = false
var money:int: 
	set(value):
		money = value
		Collected_Money.emit()
		if money >= 30 and not unlocked_dash:
			Unlock_Dash.emit()
var high_score:int
var unlocked_dash

func _ready() -> void:
	Load()
	Game_Over.connect(game_over)

func _input(event: InputEvent) -> void:
	if not FileAccess.file_exists(Save_path): return
	if event.is_action_pressed("Reset"):
		money = 0
		high_score = 0
		DirAccess.remove_absolute(Save_path)
		Deleted_Save.emit()

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
	if money > high_score: high_score = money
	
	money = 0
	
	config.set_value("Game", "high score", high_score)
	config.save(Save_path)

func Load():
	if not config.load(Save_path) == OK: return
	high_score = config.get_value("Game", "high score")
