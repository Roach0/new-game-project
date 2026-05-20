extends Control

@onready var player_deck1 = $MarginContainer/Layout/DeckContainer/Deck1
@onready var player_deck2 = $MarginContainer/Layout/DeckContainer/Deck2
@onready var player_deck3 = $MarginContainer/Layout/DeckContainer/Deck3

@onready var decks = {
	"deck1" : [],
	"deck2" : [],
	"deck3" : []
}


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	pass # Replace with function body.
