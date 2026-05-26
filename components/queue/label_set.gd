extends Label

@export var max_font_size: int = 32
@export var min_font_size: int = 8

func _ready():
	resized.connect(_fit_text)
	_fit_text()

func _fit_text():
	var parent_width = get_parent_control().size.x
	var font_size = max_font_size

	while font_size > min_font_size:
		add_theme_font_size_override("font_size", font_size)
		await get_tree().process_frame  # let Godot recalculate layout
		if get_minimum_size().x <= parent_width:
			break
		font_size -= 1
