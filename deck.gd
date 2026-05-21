class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []
signal deck_draw(Card)

var cards: Array[Card] = []
var discards: Array[Card] = []

func _ready() -> void:
	build_deck()

func _process(delta: float) -> void:
	pass

func card_draw():
	if cards.is_empty():
		print("card draw func: Deck Empty")
		return
	if MissionManager.is_queue_full:
		print("card draw func : Queue is full")
		return
	var card = cards.pop_front()
	discards.append(card)
	return card

func build_deck():
	for card in starting_cards:
		cards.append(card.duplicate())
		cards.shuffle()

func _on_button_pressed() -> void:
	if MissionManager.is_queue_full:
		print("deck button press : Queue is full")
		return
	deck_draw.emit(card_draw())
