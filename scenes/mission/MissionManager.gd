extends Node

@onready var queue: CardQueue = $MarginContainer/Layout/CardQueue
@onready var deck_container = $MarginContainer/Layout/PlayerPanel/DeckContainer
@onready var encounter_space = $MarginContainer/Layout/EncounterSpace
@onready var player = $MarginContainer/Layout/PlayerPanel/sep3/Player

var deck_scene = preload("res://scenes/components/deck/deck.tscn")
var encounter_scene = preload("res://scenes/components/encounter/encounter.tscn")

func _ready():
	queue.discard.connect(_on_discard)
	player_panel_assembly(Global.current_decks)
	load_encounter(Global.next_encounter)

 
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

func load_encounter(encounter: EncounterResource) -> void:
	if encounter == null:
		push_warning("load_encounter: encounter is null")
		return
	for child in encounter_space.get_children():
		child.queue_free()
	var instance = encounter_scene.instantiate()
	encounter_space.add_child(instance)
	instance.assemble_encounter(encounter)

func init_effects_controller(queue, encounter_space, player):
		EffectsController.card_queue = queue


# handlers
func _on_draw_request(deck: Deck) -> void:
	if is_queue_full():
		return
	var card = deck.draw_card()
	if card == null:
		return
	var queue_node = queue.add_card(card)
	if card.trigger == CardResource.Trigger.ON_DRAW:
		EffectsController.resolve_effects(card, queue_node) # pass entity here later

func _on_discard(card: CardResource) -> void:
	for child in deck_container.get_children():
		if child.deck_id == card.source_deck_id:
			child.discard(card)
			return
	push_warning("MissionManager: no deck found for source_deck_id '%s'" % card.source_deck_id)

func _on_action_button_pressed() -> void:
	pass # Replace with function body.


# methods
func remove_deck(deck_id: String) -> void:
	Global.unload_deck(deck_id)
	for child in deck_container.get_children():
		if child.deck_id == deck_id:
			child.queue_free()
			break
