extends HBoxContainer
class_name Player

@onready var condition: ProgressBar = $Condition
@onready var energy: ProgressBar = $Energy
@onready var nerve: ProgressBar = $Nerve
@onready var accuracy: ProgressBar = $Accuracy

# ghost is just a background bar for the drain visual when pbars lose value.
# don't panic it's not haunted.

var _ghosts: Dictionary = {}

func _ready() -> void:
	_ghosts = {
		"condition": _make_ghost(condition),
		"energy":    _make_ghost(energy),
		"nerve":     _make_ghost(nerve),
		"accuracy":  _make_ghost(accuracy),
	}

func _make_ghost(bar: ProgressBar) -> ProgressBar:
	# --- wrap the real bar in a plain Control so we can overlay the ghost ---
	var wrapper := Control.new()
	wrapper.size_flags_horizontal = bar.size_flags_horizontal
	wrapper.size_flags_vertical   = bar.size_flags_vertical
	wrapper.custom_minimum_size   = bar.custom_minimum_size

	# insert wrapper where the bar currently sits, then reparent bar into it
	var parent = bar.get_parent()
	var idx    = bar.get_index()
	parent.add_child(wrapper)
	parent.move_child(wrapper, idx)
	bar.reparent(wrapper)

	# anchor bar to fill the wrapper completely
	bar.anchor_right  = 1.0
	bar.anchor_bottom = 1.0
	bar.offset_right  = 0.0
	bar.offset_bottom = 0.0

	# --- create the ghost with matching properties ---
	var ghost := ProgressBar.new()
	ghost.min_value   = bar.min_value
	ghost.max_value   = bar.max_value
	ghost.value       = bar.value
	ghost.fill_mode   = bar.fill_mode   # preserves FILL_BOTTOM_TO_TOP
	ghost.show_percentage = false

	# anchor ghost to fill the wrapper too, sitting behind the real bar
	ghost.anchor_right  = 1.0
	ghost.anchor_bottom = 1.0
	ghost.offset_right  = 0.0
	ghost.offset_bottom = 0.0

	# muted fill style for the ghost trail
	var fill_style := StyleBoxFlat.new()
	fill_style.bg_color = Color(0.6, 0.6, 0.6, 0.5)  # adjust per stat

	var bg_style := StyleBoxFlat.new()
	bg_style.bg_color = Color(0, 0, 0, 0)             # transparent — real bar BG shows through

	ghost.add_theme_stylebox_override("fill", fill_style)
	ghost.add_theme_stylebox_override("background", bg_style)

	wrapper.add_child(ghost)
	wrapper.move_child(ghost, 0)  # ghost behind the real bar
	
	return ghost

func modify_stat(stat: String, value: int) -> void:
	var bar: ProgressBar = get(stat)
	if bar == null:
		push_warning("Player: no stat found for '%s'" % stat)
		return

	bar.value += value
	_tween_ghost(stat, bar.value)
	_pulse_bar(bar)

func _tween_ghost(stat: String, target: float) -> void:
	var ghost: ProgressBar = _ghosts.get(stat)
	if ghost == null:
		return

	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(ghost, "value", target, 1.2)

func _pulse_bar(bar: ProgressBar) -> void:
	bar.pivot_offset = bar.size / 2.0
	
	var ghost: ProgressBar = _ghosts.get(_bar_to_stat(bar))
	if ghost:
		ghost.pivot_offset = ghost.size / 2.0

	var tween = create_tween()

	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(bar, "scale", Vector2(1.08, 1.08), 0.08)
	if ghost:
		tween.parallel().tween_property(ghost, "scale", Vector2(1.08, 1.08), 0.08)

	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(bar, "scale", Vector2(1.0, 1.0), 0.5)
	if ghost:
		tween.parallel().tween_property(ghost, "scale", Vector2(1.0, 1.0), 0.5)

func _bar_to_stat(bar: ProgressBar) -> String:
	for stat in _ghosts:
		if get(stat) == bar:
			return stat
	return ""
