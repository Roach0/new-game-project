extends Label

@export var max_font_size: int = 16
@export var min_font_size: int = 6

func _ready():
	resized.connect(_fit_text)

func _fit_text():
	var available_width = size.x
	if available_width <= 0:
		return

	var font = get_theme_font("font")
	var font_size = max_font_size  # renamed from 'size'

	while font_size > min_font_size:
		var text_width = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		if text_width <= available_width:
			break
		font_size -= 1

	add_theme_font_size_override("font_size", font_size)
