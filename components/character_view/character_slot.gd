extends AspectRatioContainer
class_name CharacterSlot


@onready var title = $BG/VBoxContainer/Title
@onready var state = $BG/VBoxContainer/State
var encounter_type: CharacterResource = null

func _ready() -> void:
	clear()

func is_empty() -> bool:
	return encounter_type == null

func assign(data: CharacterResource) -> void:
	if data == null:
		return
	encounter_type = data
	title.text = data.card_name
	state.text = data.description

func clear() -> void:
	encounter_type = null
	title = ""
	state = ""

func _on_button_pressed() -> void:
	clear()
