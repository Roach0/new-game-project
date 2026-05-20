extends AspectRatioContainer

@export var starting_cards: Array[Card] = []
@export var queue: NodePath

var cards: Array[Card] = []
var discards: Array[Card] = []

func _ready() -> void:
	build_deck()

func _process(delta: float) -> void:
	pass

func card_draw():
	if cards.is_empty():
		return {
			"name": "cards_empty",
			"desc": "Deck is empty"
		}
	var card = cards.pop_front()
	discards.append(card)
	return card
	
func build_deck():
	for card in cards:
		cards.append(card.duplicate())
		


func _on_button_pressed() -> void:
	if queue.full == true:
		pass
	
