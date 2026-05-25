extends Control

var current_decks: Dictionary[ String , DeckResource ] = {}

func _ready():
	load_deck(preload("res://resources/default_decks/unarmed.tres")) #temporary loads

#Methods
func load_deck(deck: DeckResource) -> void:
	current_decks[str(current_decks.size() + 1)] = deck
func unload_deck(key: String) -> void:
	current_decks.erase(key)
func has_deck(key: String) -> bool:
	return current_decks.has(key)
