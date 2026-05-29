extends Resource
class_name CardResource

enum Target {
	SELF,
	PLAYER,
	QUEUE_GROUP,
	# ENCOUNTER
	# ENCOUNTER_GROUP
	}

@export var card_name:String = ""
@export var description:String = ""
@export var icon: Texture2D
var source_deck_id: String = ""

# effects stuff
@export var target:Target
@export var effects:Array[EffectResource] = []

@export var trigger: String = "Instant"
@export var effect_description: String = "Does a thing"

static func target_label(t: Target) -> String:
	match t:
		Target.SELF: return "Self"
		Target.PLAYER: return "Player"
		Target.QUEUE_GROUP: return "Group"
		_: return "Unknown"
