extends AspectRatioContainer
class_name EncounterSlot


@onready var title = $BG/VBoxContainer/Title
@onready var state = $BG/VBoxContainer/State
var encounter_type: EncounterEntity = null

func _ready() -> void:
	clear()

func is_empty() -> bool:
	return encounter_type == null

func assign(data: EncounterEntity) -> void:
	if data == null:
		return
	encounter_type = data
	title.text = data.card_name
	state.text = data.description

func clear() -> void:
	encounter_type = null
	$BG/VBoxContainer/Title.text = ""
	$BG/VBoxContainer/State.text = ""

func _on_button_pressed() -> void:
	clear()
