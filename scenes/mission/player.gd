extends HBoxContainer
class_name Player

@onready var condition: ProgressBar = $Condition
@onready var energy: ProgressBar = $Energy
@onready var nerve: ProgressBar = $Nerve
@onready var accuracy: ProgressBar = $Accuracy

func _ready() -> void:
	pass

func modify_stat(stat: String, value: int):
	var bar: ProgressBar = get(stat)
	if bar == null:
		push_warning("Player: no stat found for '%s'" % stat)
		return
	bar.value += value
	_pulse_bar(bar)

func _pulse_bar(bar: ProgressBar) -> void:
	bar.pivot_offset = bar.size / 2.0

	var tween = create_tween()
	
	# snap out fast
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(bar, "scale", Vector2(1.08, 1.08), 0.08)
	
	# return slow and smooth
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(bar, "scale", Vector2(1.0, 1.0), 0.5)
