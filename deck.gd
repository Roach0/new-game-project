class_name Deck
extends AspectRatioContainer

@export var starting_cards: Array[Card] = []
@export var queue: NodePath

var queue_node: CardQueue
var cards: Array[Card] = []
var discards: Array[Card] = []

func _ready() -> void:
	build_deck()

func _process(delta: float) -> void:
	pass

func card_draw():
	if cards.is_empty() || queue_node.is_full():
		return
	var card = cards.pop_front()
	discards.append(card)
	return card
	
func build_deck():
	for card in cards:
		cards.append(card.duplicate())
		cards.shuffle()
		


func _on_button_pressed() -> void:
	card_draw()
