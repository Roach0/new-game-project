class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []
signal deck_draw(Card)
signal deck_empty
signal deck_setup

var cards: Array[Card] = []
var discards: Array[Card] = []

func _ready() -> void:
	build_deck()

func _process(delta: float) -> void:
	pass

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

func _on_button_pressed() -> void:
	var card = draw_card()
	if card == null:
		return
	deck_draw.emit(card)

func redraw():
	deck_empty.emit(false)
	pass
