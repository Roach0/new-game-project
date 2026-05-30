extends EffectResource
class_name UpdateNerve

var stat_target:String = "nerve"
@export var amount: int = 0

func tick(target:Player) -> void:
	target.modify_stat(stat_target, amount)
