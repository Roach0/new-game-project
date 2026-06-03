extends Node

# control points
var encounter_space: MarginContainer
var card_queue: CardQueue
var player:Player


# signals


func resolve_effects(card: CardResource, queue_node: QueueSlot) -> void:
	if card.effects.is_empty():
		push_warning("resolve_effects: no effects on card '%s'" % card.card_name)
		return
	for effect in card.effects:
		var target := get_effect_targets(effect.target, queue_node)
		print(target)
		for t in target:
			effect.tick(t)

func get_effect_targets(
	target_type: EffectResource.Target,
	queue_node: QueueSlot = null,
	) -> Array:
	
	print("target enum value: ", target_type)
	match target_type:
		EffectResource.Target.PLAYER:
			return [player]
		EffectResource.Target.SELF:
			return[queue_node]
		EffectResource.Target.QUEUE_GROUP:
			return []
		EffectResource.Target.QUEUE_POS:
			return []
		EffectResource.Target.ENCOUNTER_GROUP:
			return []
		EffectResource.Target.ENCOUNTER_POS:
			return []
		_:
			push_warning("get_effect_targets: unhandled target type %d" % target_type)
			return []
