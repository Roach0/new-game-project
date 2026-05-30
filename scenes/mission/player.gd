extends HBoxContainer
class_name Player


@onready var condition: ProgressBar = $Condition
@onready var energy: ProgressBar = $Energy
@onready var nerve: ProgressBar = $Nerve
@onready var accuracy: ProgressBar = $Accuracy

func _ready() -> void:
	pass

# methods

func modify_stat(stat: ProgressBar, value: int):
	stat.value += value
