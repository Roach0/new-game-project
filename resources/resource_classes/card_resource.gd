extends Resource
class_name CardResource

enum Target {
	SELF,
	PLAYER,
	QUEUE_GROUP,
	QUEUE_POS,
	ENCOUNTER,
	# ENCOUNTER_GROUP
}

enum Trigger {
	ON_DRAW,
	ON_DISCARD,
	ON_TURN_END,
	ON_CLICK,
	WHILE
}

@export var card_name: String = ""
@export var icon: Texture2D
var source_deck_id: String = ""
@export var trigger: Trigger = Trigger.ON_DRAW
@export var effect_description: String = "Does a thing"

# effects stuff
@export var target: Target
@export var effects: Array[EffectResource] = []

static func target_label(t: Target) -> String:
	match t:
		Target.SELF: return "This Card"
		Target.PLAYER: return "Yourself"
		Target.QUEUE_POS: return "Card Positions"
		Target.QUEUE_GROUP: return "Card Group"
		Target.ENCOUNTER: return "An Enemy"
		_: return "no_target"

static func trigger_label(t: Trigger) -> String:
	match t:
		Trigger.ON_DRAW: return "Draw"
		Trigger.ON_DISCARD: return "Discard"
		Trigger.ON_TURN_END: return "Turn End"
		Trigger.ON_CLICK: return "Click"
		Trigger.WHILE: return "While"
		_: return "Unknown"
