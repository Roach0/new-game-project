class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []

signal deck_empty
signal draw_request

var cards: Array[Card] = []
var discards: Array[Card] = []

func _ready() -> void:
	var 
	build_deck()
func _process(delta: float) -> void:
	pass

# queries
func is_empty() ->  bool:
	return cards.is_empty()

# methods
func build_deck():
	for card in starting_cards:
		cards.append(card.duplicate())
	cards.shuffle()
func draw_card() -> Card:
	if cards.is_empty():
		deck_empty.emit()
		print("deck:empty")
		return null
	var card = cards.pop_front()
	return card
func redraw():
	pass #unfinished

# handlers
func _on_button_pressed() -> void:
	draw_request.emit()
