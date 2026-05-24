class_name DeckResource
extends Resource

enum DeckType { WEAPON , SKILL }

@export var deck_id: String = ""
@export var cards: Array[CardResource] = []
@export var deck_type: DeckType = DeckType.WEAPON
