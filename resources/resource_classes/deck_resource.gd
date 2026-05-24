class_name LoadDeck
extends Resource

enum DeckType { WEAPON , SKILL }

@export var cards: Array[Card] = []
@export var deck_type: DeckType = DeckType.WEAPON
