extends Node3D

@onready var scorer = $Scorer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scorer.add_dice($Dice)
	scorer.add_dice($Dice2)
	scorer.add_dice($Dice3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return
