class_name CardQueue
extends HBoxContainer

const MAX_CARDS = 6
var card_queue: Array[Card] = []




func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func is_full() -> bool: 
	return card_queue.size() >= MAX_CARDS
