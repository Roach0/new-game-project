class_name BurnEffect
extends EffectResource

@export var damage: int = 0

func _init() -> void:
	type = "burn"
	timing = Timing.PER_TURN
