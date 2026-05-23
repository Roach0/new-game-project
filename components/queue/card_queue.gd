class_name CardQueue
extends HBoxContainer

@onready var slots:Array[QueueSlot] = [$Slot0,$Slot1,$Slot2,$Slot3,$Slot4,$Slot5]

func _ready() -> void:
	MissionManager.card_queue = $CardQueue # self assignment to scene

func _process(delta: float) -> void:
	pass

func open_slots() -> Array:
	return slots.filter(func(s): return s.is_empty())
func next_open_slot() -> QueueSlot:
	return open_slots().front()  # returns null if none available
func is_full() -> bool:
	return open_slots().is_empty()

func add_card(card: Card) -> void:
	if is_full():
		return
	var slot = next_open_slot()
	if slot:
		slot.assign(card)
		MissionManager.is_queue_full = is_full()

func remove_card(slot: QueueSlot) -> void:
	slot.clear()
	MissionManager.is_queue_full = is_full()

func _on_deck_draw(card:Card) -> void:
	if is_full():
		return
	update_queue("add",card)
