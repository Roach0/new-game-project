extends AspectRatioContainer
class_name CharacterSlot


@onready var title = $HBoxContainer/BG/Name
@onready var state = $HBoxContainer/BG/State
@onready var Condition : ProgressBar = $HBoxContainer/Condition
@onready var Energy : ProgressBar = $HBoxContainer/Energy
@onready var Nerve : ProgressBar = $HBoxContainer/Nerve
@onready var Alert : ProgressBar = $HBoxContainer/Alert

var encounter_type: CharacterResource = null

func _ready() -> void:
	clear()

func is_empty() -> bool:
	return encounter_type == null

func setup(data: CharacterResource) -> void:
	if data == null:
		return
	encounter_type = data
	title.text = data.name          # was data.card_name
	state.text = str(data.state)    # enum needs str() conversion
	Condition.value = data.condition
	Energy.value = data.energy
	Nerve.value = data.nerve
	Alert.value = data.alert

func clear() -> void:
	encounter_type = null
	title.text = ""   # needs .text
	state.text = "" 

func _on_button_pressed() -> void:
	clear()
