extends VBoxContainer
class_name Encounter

@onready var encounter_characters : Array[CharacterResource]
@onready var top_row = $TopRow
@onready var bot_row = $BotRow

var character_slot = preload("res://components/character_slot/character_slot.tscn")

func assemble_encounter(encounter:EncounterResource) -> void:
	for c in encounter.characters:
		encounter_characters.append(c)
	encounter_characters.shuffle()
	for c in encounter_characters:
		if top_row.get_child_count() < 5:
			top_row.add_child(character_slot)
