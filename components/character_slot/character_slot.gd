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

# queries
func is_empty() -> bool:
	return encounter_type == null

# methods
func clear() -> void:
	encounter_type = null
	title.text = ""   # needs .text
	state.text = "" 

#scene build
func setup(character: CharacterResource) -> void:
	if character == null:
		return
	encounter_type = character
	title.text = "_" + character.name
	state.text = CharacterResource.State.keys()[character.state].to_lower() + "_"
	Condition.value = character.condition
	Energy.value = character.energy
	Nerve.value = character.nerve
	Alert.value = character.alert

# handlers
func _on_button_pressed() -> void:
	clear()
