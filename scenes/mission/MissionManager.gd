extends Node

@onready var deck: Deck = $MarginContainer/Layout/DeckContainer/Deck1
@onready var card_queue: CardQueue = $MarginContainer/Layout/CardQueue
var is_deck_empty: bool = false

func ready():
	pass

func is_queue_full() -> bool:
	if card_queue == null:
		print("MissionManager: queue is null")
		return false
	return card_queue.is_full()

func card_draw_to_queue():
	pass

fun _on
