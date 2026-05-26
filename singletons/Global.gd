extends Control

var current_decks: Dictionary[String, DeckResource] = {}
var next_encounters: Array[EncounterResource] = []
var _next_id: int = 1

func _ready():
	load_deck(preload("res://resources/default_decks/unarmed.tres"))
	load_deck(preload("res://resources/default_decks/unarmed.tres"))
	load_deck(preload("res://resources/default_decks/unarmed.tres"))

func load_deck(deck: DeckResource) -> void:
	current_decks[str(_next_id)] = deck
	_next_id += 1

func load_encounter(encounter:EncounterResource):
	next_encounters
	# later, expand out to option selection later

func unload_deck(key: String) -> void:
	current_decks.erase(key)

func has_deck(key: String) -> bool:
	return current_decks.has(key)
