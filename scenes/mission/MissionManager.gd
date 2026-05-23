extends Node

@onready var deck: Deck = $MarginContainer/Layout/DeckContainer/Deck1
@onready var queue: CardQueue = $MarginContainer/Layout/CardQueue
var is_deck_empty: bool = false

func _ready():
	deck.draw_request.connect(_on_draw_request)

# queries
func is_queue_full() -> bool:
	if queue == null:
		print("MissionManager: queue is null")
		return false
	return queue.is_full()

# methods
func _on_draw_request(): # later we use this send deck id, for multi deck scaling.
	if is_queue_full():
		print("manager: queue is full")
		return
	var card = deck.draw_card() # removes card from deck to here
	queue.add_card(card)
