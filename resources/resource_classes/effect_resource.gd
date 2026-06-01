class_name EffectResource
extends Resource

@export var effect_id: String
@export var target: Target

func _tick() -> void:
	pass

enum Target {
	PLAYER = 0,
	SELF = 1,
	QUEUE_GROUP = 2,
	QUEUE_POS = 3,
	ENCOUNTER_GROUP = 4,
	ENCOUNTER_POS = 5
}

var tags: Array[String] = []
