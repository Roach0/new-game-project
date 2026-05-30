extends EffectResource
class_name UpdateNerve

@export var stat_target: String = "condition"
@export var amount: float = 0.0
@export var duration: int = 1  # turns remaining

func on_tick(target: Node) -> void:
	if target.has_method("modify_stat"):
		target.modify_stat(stat_target, amount)
	duration -= 1

func is_expired() -> bool:
	return duration <= 0
