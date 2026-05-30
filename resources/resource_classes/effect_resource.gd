class_name EffectResource
extends Resource

# example: deal 3 damage

@export var effect_description: String
@export var target: Target

enum Target {
	PLAYER = 0,
	SELF = 1,
	QUEUE_GROUP = 2,
	QUEUE_POS = 3,
	ENCOUNTER = 4,
	# ENCOUNTER_GROUP
}
