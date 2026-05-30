class_name EffectResource
extends Resource

# example: deal 3 damage

@export var effect_description: String



# Only called for CLICK timing, after target is chosen
func on_resolve(slot: QueueSlot, target: CharacterSlot) -> void:
	pass

# Only called for PERSISTENT, once per turn tick if you need it
func on_turn_end(slot: QueueSlot) -> void:
	pass
