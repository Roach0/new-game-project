extends EffectResource
class_name UpdateNerve

@export var stat_target: String = "condition"
@export var amount: int = 0

func on_tick(target: Node) -> void:
	if target.has_method("modify_stat"):
		target.modify_stat(stat_target, amount)
