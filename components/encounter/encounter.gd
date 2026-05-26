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
		add_character_slot(c)

func add_character_slot(character: CharacterResource) -> void:
	var slot = character_slot.instantiate()
	if top_row.get_child_count() < 5:
		top_row.add_child(slot)
		slot.setup(character)
		return
	if bot_row.get_child_count() < 5:
		bot_row.add_child(slot)
		slot.setup(character)
		return
	print("encounter.gd ERROR : cannot place character : scene full")
