extends EffectResource
class_name QueueLock
var slot_targets:Array[QueueSlot] = []

func tick(target: QueueSlot) -> void:
	var queue_manager = target.get_parent().get_parent().get_parent()
	queue_manager.lock_queue_slot(target)
