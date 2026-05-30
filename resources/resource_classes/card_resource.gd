extends Resource
class_name CardResource

enum Trigger {
	ON_DRAW,
	ON_DISCARD,
	ON_TURN_END,
	ON_CLICK,
	WHILE
}

@export var card_name: String = ""
@export var icon: Texture2D
@export var trigger: Trigger = Trigger.ON_DRAW
@export var effect_description: String = "Does a thing"
@export var target_desc: String = "target_desc"
var source_deck_id: String = ""

# effects stuff
@export var effects: Array[EffectResource] = []

static func target_label(t: EffectResource.Target) -> String:
	match t:
		EffectResource.Target.SELF: return "This Card"
		EffectResource.Target.PLAYER: return "Yourself"
		EffectResource.Target.QUEUE_POS: return "Card Positions"
		EffectResource.Target.QUEUE_GROUP: return "Card Group"
		EffectResource.Target.ENCOUNTER: return "An Enemy"
		_: return "no_target"

static func trigger_label(t: Trigger) -> String:
	match t:
		Trigger.ON_DRAW: return "Draw"
		Trigger.ON_DISCARD: return "Discard"
		Trigger.ON_TURN_END: return "Turn End"
		Trigger.ON_CLICK: return "Click"
		Trigger.WHILE: return "While"
		_: return "no_trigger"
