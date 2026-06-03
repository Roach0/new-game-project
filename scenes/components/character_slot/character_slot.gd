extends AspectRatioContainer
class_name CharacterSlot


@onready var title = $HBoxContainer/BG/Name
@onready var state = $HBoxContainer/BG/State 
@onready var Condition : ProgressBar = $HBoxContainer/Condition
@onready var Energy : ProgressBar = $HBoxContainer/Energy
@onready var Nerve : ProgressBar = $HBoxContainer/Nerve
@onready var Alert : ProgressBar = $HBoxContainer/Alert


var character: CharacterResource = null

func _ready() -> void:
	clear()

# queries
func is_empty() -> bool:
	return character == null

# data methods
func clear() -> void:
	character = null
	title.text = ""   # needs .text
	state.text = "" 

func update_condition(value) -> void:
	Condition.value += value
	if value < 0:
		damaged(value)
	return

# behaviour methods
func damaged(value) -> void:
	pass

#scene build
func setup(c: CharacterResource) -> void:
	if character == null:
		return
	character = c
	title.text = "_" + character.name
	state.text = CharacterResource.State.keys()[character.state].to_lower() + "_"
	Condition.value = character.condition
	Energy.value = character.energy
	Nerve.value = character.nerve
	Alert.value = character.alert

# handlers
func _on_button_pressed() -> void:
	clear()
