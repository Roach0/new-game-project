extends HBoxContainer
class_name Player


@onready var condition: ProgressBar = $Condition
@onready var energy: ProgressBar = $Energy
@onready var nerve: ProgressBar = $Nerve
@onready var accuracy: ProgressBar = $Accuracy



func _ready() -> void:
	pass

# methods


func modify_stat(stat: String, value: int):
	var bar: ProgressBar = get(stat)
	if bar == null:
		push_warning("Player: no stat found for '%s'" % stat)
		return
	bar.value += value
