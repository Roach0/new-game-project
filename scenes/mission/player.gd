extends HBoxContainer
class_name Player


@onready var condition: ProgressBar = $MarginContainer/Layout/PlayerPanel/sep3/Player/Condition
@onready var energy: ProgressBar = $MarginContainer/Layout/PlayerPanel/sep3/Player/Energy
@onready var nerve: ProgressBar = $MarginContainer/Layout/PlayerPanel/sep3/Player/Nerve
@onready var accuracy: ProgressBar = $MarginContainer/Layout/PlayerPanel/sep3/Player/Accuracy

func _ready() -> void:
	pass

# methods

func modify_stat(stat: ProgressBar, value: int):
	stat.value += value
