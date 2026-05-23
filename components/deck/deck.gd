class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []

signal send_card(Card)
signal deck_empty
signal queue_check_request

var cards: Array[Card] = []
var discards: Array[Card] = []

# queries
func is_empty() ->  bool:
	return cards.is_empty()

# starter Pkmn
func _ready() -> void:
	build_deck()
func _process(delta: float) -> void:
	pass

# meth
func build_deck():
	for card in starting_cards:
		cards.append(card.duplicate())
		cards.shuffle()
func draw_card():
	if cards.is_empty():
		deck_empty.emit()
		return
	var card = cards.pop_front()
	discards.append(card)
	return card

# inputs
func _on_button_pressed() -> void:
	if is_empty():
		deck_empty.emit()
		return
	queue_check_request.emit()

func redraw(): #unfinished
	pass
