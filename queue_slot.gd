extends AspectRatioContainer
class_name QueueSlot

var card_data: Card = null

func _ready() -> void:
	$BG/Title.text = ""
	$BG/Description.text = ""

func is_empty() -> bool:
	return card_data == null

func assign(data: Card) -> void:
	card_data = data
	$BG/Title.text = data.card_name
	$BG/Description.text = data.description

func clear() -> void:
	card_data = null
	$BG/Title.text = ""
	$BG/Description.text = ""

func _on_button_pressed() -> void:
	clear()
