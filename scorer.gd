extends Node3D

var dices = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	dices = GameManager.selected_dices
	if dices != []:
		print(get_score())

func add_dice(dice):
	dices.append(dice)

func del_dice(dice):
	dices.erase(dice)

func get_score() -> int:
	var score = 0
	for dice in dices:
		score+=dice.get_value()
	return score
