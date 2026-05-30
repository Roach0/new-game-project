extends Node
#autoload singleton btw

var current_decks: Dictionary[String, DeckResource] = {}
var next_encounter: EncounterResource
var _next_id: int = 1

func _ready():
	# testing loads
	load_deck(preload("res://resources/cards/test_deck/test_deck.tres"))

	load_encounter(preload("res://resources/encounters/warehouse.tres"))

func load_deck(deck: DeckResource) -> void:
	current_decks[str(_next_id)] = deck
	_next_id += 1

func load_encounter(encounter:EncounterResource) ->void:
	next_encounter = encounter

func unload_deck(key: String) -> void:
	current_decks.erase(key)

func has_deck(key: String) -> bool:
	return current_decks.has(key)
