class_name EffectResource
extends Resource

enum ExecutionType { PASSIVE, ACTIVE }

@export var execution_type: ExecutionType = ExecutionType.PASSIVE
@export var effects: Array[EffectResource] = []
