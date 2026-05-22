extends Node

var deck: Deck = null
var card_queue: CardQueue = null  # set this on scene load
var is_deck_empty: bool = false

func is_queue_full() -> bool:
	if card_queue == null:
		return false
	return card_queue.is_full()
