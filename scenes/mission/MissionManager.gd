extends Node

var is_deck_empty: bool = false
var card_queue: CardQueue = null  # set this on scene load

func is_queue_full() -> bool:
	if card_queue == null:
		return false
	return card_queue.is_full()
