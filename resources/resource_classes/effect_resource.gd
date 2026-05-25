class_name EffectResource
extends Resource

enum ExecutionType { 
	STAGING,
	PASSIVE,
	ACTIVE
}

@export var execution_type: ExecutionType = ExecutionType.PASSIVE
@export var value: int = 0
