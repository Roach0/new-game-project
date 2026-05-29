extends Resource
class_name CardResource

enum Target {
	SELF,
	PLAYER,
	QUEUE_GROUP,
	# ENCOUNTER
	# ENCOUNTER_GROUP
	}

@export var effects:Array[EffectResource] = []

@export var card_name:String = ""
@export var description:String = ""
@export var icon: Texture2D
var source_deck_id: String = ""
