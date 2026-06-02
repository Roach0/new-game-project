extends Node

@onready var queue: CardQueue = $MarginContainer/Layout/CardQueue
@onready var deck_container = $MarginContainer/Layout/PlayerPanel/DeckContainer
@onready var encounter_space = $MarginContainer/Layout/EncounterSpace
@onready var player = $MarginContainer/Layout/PlayerPanel/sep3/Player

var deck_scene = preload("res://components/deck/deck.tscn")
var encounter_scene = preload("res://components/encounter/encounter.tscn")

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

# handlers
func _on_draw_request(deck: Deck) -> void:
	if is_queue_full():
		return
	var card = deck.draw_card()
	if card == null:
		return
	var queue_node = queue.add_card(card)
	if card.trigger == CardResource.Trigger.ON_DRAW:
		resolve_effects(card, queue_node) # pass entity here later
	

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

func resolve_effects(card: CardResource, queue_node: QueueSlot) -> void:
	if card.effects.is_empty():
		push_warning("resolve_effects: no effects on card '%s'" % card.card_name)
		return
	for effect in card.effects:
		var target := get_effect_targets(effect.target, queue_node)
		print(target)
		for t in target:
			effect.tick(t)

func get_effect_targets(
	target_type: EffectResource.Target,
	queue_node: QueueSlot = null,
	) -> Array:
	
	print("target enum value: ", target_type)
	match target_type:
		EffectResource.Target.PLAYER:
			return [player]
		EffectResource.Target.SELF:
			return[queue_node]
		EffectResource.Target.QUEUE_GROUP:
			return []
		EffectResource.Target.QUEUE_POS:
			return []
		EffectResource.Target.ENCOUNTER_GROUP:
			return []
		EffectResource.Target.ENCOUNTER_POS:
			return []
		_:
			push_warning("get_effect_targets: unhandled target type %d" % target_type)
			return []
