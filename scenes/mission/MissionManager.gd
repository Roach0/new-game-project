extends Node

@onready var queue: CardQueue = $MarginContainer/Layout/CardQueue
@onready var decks: Dictionary[ String , DeckResource ] = Global.current_decks
@onready var deck_container = $MarginContainer/Layout/PlayerPanel/DeckContainer
@onready var deck_scene = preload("res://components/deck/deck.tscn")

func _ready():
	# deck.draw_request.connect(_on_draw_request)
	queue.discard.connect(_on_discard)
	player_panel_assembly(decks)

# queries
func is_queue_full() -> bool:
	if queue == null:
		print("MissionManager: queue is null")
		return false
	return queue.is_full()

# methods


# handlers
func _on_draw_request(deck:Deck):
	if is_queue_full():
		return
	var card = deck.draw_card()
	queue.add_card(card)
func _on_discard(card: CardResource , deck:Deck):
	print("this is happening")
	deck.discard(card)

# scene builders
func player_panel_assembly(decks):
	for deck in decks:
		var d = deck_scene.instantiate()
		deck_container.add_child(d)
		
