extends AspectRatioContainer


@onready var discards = []
@onready var cards = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _card_draw():
	if cards.is_empty():
		return {
			"name": "cards_empty",
			"desc": "Deck is empty"
		}
	var card = cards.pop_front()
	discards.push_back(card)
	return card
