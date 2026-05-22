extends AspectRatioContainer
class_name QueueSlot


@onready var title = $BG/Title
@onready var description = $BG/Description
var card_data: Card = null

func _ready() -> void:
	clear()

func is_empty() -> bool:
	return card_data == null

func assign(data: Card) -> void:
	if data == null:
		return
	card_data = data
	title.text = data.card_name
	description.text = data.description

func clear() -> void:
	card_data = null
	$BG/Title.text = ""
	$BG/Description.text = ""

func _on_button_pressed() -> void:
	clear()
