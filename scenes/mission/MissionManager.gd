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
	if card:
		# add an if here later my boi
		resolve_effects(card)
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

func resolve_effects(card: CardResource) -> void:
	if card.effects.is_empty():
		push_warning("resolve_effects: no effects on card '%s'" % card.card_name)
		return
	for effect in card.effects:
		var targets := get_effect_targets(effect.target)
		print(targets)
		for target in targets:
			effect.tick(target)

func get_effect_targets(target: EffectResource.Target) -> Array:
	print("target enum value: ", target)
	match target:
		EffectResource.Target.PLAYER:
			return [player]
		EffectResource.Target.SELF:
			return []  # current endpoint
		EffectResource.Target.ENCOUNTER:
			return []  # current endpoint
		_:
			push_warning("get_effect_targets: unhandled target type %d" % target)
			return []
