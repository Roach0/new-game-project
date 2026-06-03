extends EffectResource
class_name AdjacentDiscard
var slot_targets:Array[QueueSlot] = []

var queue_manager:CardQueue

func tick(target: QueueSlot) -> void:
	
	queue_manager = target.get_parent().get_parent().get_parent()
	
	queue_manager.lock_queue_slot(target)
	
	#var slot_number = next_slot.name.lstrip("Slot")
	#var next_slot_button = get_node("VBoxContainer/CardQueue/Slot" + next_slot_number)
