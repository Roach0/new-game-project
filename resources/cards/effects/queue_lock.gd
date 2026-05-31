extends EffectResource
class_name QueueLock
var slot_targets:Array[QueueSlot] = []

func tick(target: QueueSlot) -> void:
	var card_queue = target.get_parent().get_parent() # adjust path as needed
	card_queue.lock_queue_slot(target)
