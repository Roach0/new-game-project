extends Node

@onready var deck: Deck = $MarginContainer/Layout/DeckContainer/Deck1
@onready var queue: CardQueue = $MarginContainer/Layout/CardQueue
var is_deck_empty: bool = false

func _ready():
	deck.draw_request.connect(_on_draw_request)
	queue.discard_request.connect(_on_discard)

# queries
func is_queue_full() -> bool:
	if queue == null:
		print("MissionManager: queue is null")
		return false
	return queue.is_full()

# handlers
func _on_draw_request(): # later we use this send deck id, for multi deck scaling.
	if is_queue_full():
		return
	var card = deck.draw_card() # removes card from deck to here
	queue.add_card(card)
func _on_discard(card:Card):
	print("this is happening")
	deck.discard(card)
