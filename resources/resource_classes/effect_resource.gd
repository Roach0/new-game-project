class_name EffectResource
extends Resource

enum Trigger { 
	INSTANT,
	PER_TURN,
	WHILE_PRESENT
}

enum Target {
	CHARACTER,
	SELF,
	ALL_ENEMIES,
	SLOT
}

@export var timing: Trigger
@export var target: Target
@export var duration: int = 0
