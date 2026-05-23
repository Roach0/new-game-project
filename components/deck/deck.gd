class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []

signal deck_empty
signal draw_request

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

func draw_card() -> Card:
	if cards.is_empty():
		deck_empty.emit()
		print("deck:empty")
		return null
	var card = cards.pop_front()
	return card

# inputs
func _on_button_pressed() -> void:
	draw_request.emit()

func redraw(): #unfinished
	pass
