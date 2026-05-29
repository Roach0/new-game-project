class_name EffectResource
extends Resource

enum Timing { IMMEDIATE, PERSISTENT, CLICK }

@export var timing: Timing
@export var effect_description: String


# Override in subclasses
func on_enqueue(slot: QueueSlot) -> void:
	pass

func on_dequeue(slot: QueueSlot) -> void:
	pass

# Only called for CLICK timing, after target is chosen
func on_resolve(slot: QueueSlot, target: CharacterSlot) -> void:
	pass

# Only called for PERSISTENT, once per turn tick if you need it
func on_turn_end(slot: QueueSlot) -> void:
	pass
