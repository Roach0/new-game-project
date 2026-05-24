extends AspectRatioContainer
class_name QueueSlot


@onready var title = $BG/Title
@onready var description = $BG/Description
var card: CardResource = null

signal discard_request(card: CardResource)

func _ready() -> void:
	clear()

func is_empty() -> bool:
	return card == null

func assign(data: CardResource) -> void:
	if data == null:
		return
	card = data
	title.text = data.card_name
	description.text = data.description

func clear() -> void:
	card = null
	$BG/Title.text = ""
	$BG/Description.text = ""

func _on_button_pressed() -> void:
	if card == null:
		return
	discard_request.emit(card)
	clear()
