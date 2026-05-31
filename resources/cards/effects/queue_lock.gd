extends EffectResource
class_name QueueLock

var slot_targets:Array[QueueSlot] = []

func tick(target:QueueSlot) -> void:
	target.lock_slot()
