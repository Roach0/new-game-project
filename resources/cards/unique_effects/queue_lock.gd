extends EffectResource
class_name QueueLock
var slot_targets:Array[QueueSlot] = []

var queue_manager:CardQueue

func tick(target: QueueSlot) -> void:
	queue_manager = target.get_parent().get_parent().get_parent()
	queue_manager.lock_queue_slot(target)
