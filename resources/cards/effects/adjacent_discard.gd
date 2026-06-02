extends EffectResource
class_name AdjacentDiscard
var slot_targets:Array[QueueSlot] = []

var queue_manager:CardQueue

func tick(target: QueueSlot) -> void:
	queue_manager.lock_queue_slot(target)
