class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []
@export var deck_id: String = "Default"

@onready var cards_count = $PanelContainer/MarginContainer/Panel/Draw
@onready var discards_count = $PanelContainer/MarginContainer/Panel/Discard

signal deck_empty
signal draw_request

var cards: Array[Card] = []
var discards: Array[Card] = []

func _ready() -> void:
	build_deck()

# queries
func is_empty() ->  bool:
	return cards.is_empty()

# methods
func build_deck():
	for card in starting_cards:
		cards.append(card.duplicate())
	cards_count.text = str(cards.size())
	discards_count.text = str(discards.size())
	cards.shuffle()
func draw_card() -> Card:
	if cards.is_empty():
		deck_empty.emit() #for later message n stuff
		print("deck:empty")
		return null
	var card = cards.pop_back()
	cards_count.text = str(cards.size())
	return card
func discard(card:Card):
	print("ive been called")
	discards.append(card)
	discards_count.text = str(discards.size())
func redraw():
	pass #unfinished

# handlers
func _on_button_pressed() -> void:
	draw_request.emit()
