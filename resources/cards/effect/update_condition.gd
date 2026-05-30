extends EffectResource
class_name UpdateCondition

var stat_target:String = "condition"
@export var amount: int = 0

func tick(target:Player) -> void:
	target.modify_stat(stat_target, amount)
