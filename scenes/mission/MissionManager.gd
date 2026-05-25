extends Node

@onready var queue: CardQueue = $MarginContainer/Layout/CardQueue
@onready var deck_container = $MarginContainer/Layout/PlayerPanel/DeckContainer

var deck_scene = preload("res://components/deck/deck.tscn")

func _ready():
	queue.discard.connect(_on_discard)
	player_panel_assembly(Global.current_decks)

# queries
func is_queue_full() -> bool:
	if queue == null:
		push_warning("MissionManager: queue is null")
		return false
	return queue.is_full()

# scene builders
func player_panel_assembly(decks: Dictionary) -> void:
	for deck_id in decks:
		var d = deck_scene.instantiate()
		deck_container.add_child(d)
		d.deck_id = deck_id
		d.deck_data = decks[deck_id]
		d.draw_request.connect(_on_draw_request)

# handlers
func _on_draw_request(deck: Deck) -> void:
	if is_queue_full():
		return
	var card = deck.draw_card()
	if card:
		queue.add_card(card)

func _on_discard(card: CardResource) -> void:
	for child in deck_container.get_children():
		if child.deck_id == card.source_deck_id:
			child.discard(card)
			return
	push_warning("MissionManager: no deck found for source_deck_id '%s'" % card.source_deck_id)

# methods
func remove_deck(deck_id: String) -> void:
	Global.unload_deck(deck_id)
	for child in deck_container.get_children():
		if child.deck_id == deck_id:
			child.queue_free()
			break
