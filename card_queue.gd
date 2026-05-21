class_name CardQueue
extends HBoxContainer


var MAX_CARDS = 6
var card_queue: Array[Card] = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func is_full() -> bool:
	return card_queue.size() >= MAX_CARDS

func update_queue(action:String, card:Card = null):
	if action == "add":
		if is_full():
			pass
		card_queue.append(card)
		if is_full():
			MissionManager.is_queue_full = true
	if action == "remove":
		print("Remove method not yet finished.")
		pass

func _on_deck_draw(Card: Variant) -> void:
	if MissionManager.is_deck_empty:
		print("this deck is empty")
		return
	update_queue("add", Card)
