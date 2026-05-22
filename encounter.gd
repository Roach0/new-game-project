extends HBoxContainer

var grid : Array[Array] = [[],[]]

@export var entities : Array[EncounterEntity] = []

func _ready() -> void:
	pass # Replace with function body.
func _process(delta: float) -> void:
	pass

func grid_setup():
	entities.shuffle()
