class_name CardQueue
extends MarginContainer

@onready var slots:Array[QueueSlot] = [
	$VBoxContainer/CardQueue/Slot0,
	$VBoxContainer/CardQueue/Slot1,
	$VBoxContainer/CardQueue/Slot2,
	$VBoxContainer/CardQueue/Slot3,
	$VBoxContainer/CardQueue/Slot4]

signal queue_is_full
signal discard

func _ready() -> void:
	for slot in slots:
		slot.discard_request.connect(_on_slot_discard_request)

# queries
func open_slots() -> Array:
	return slots.filter(func(s): return s.is_empty())
func next_open_slot() -> QueueSlot:
	return open_slots().front()
func is_full() -> bool:
	return open_slots().is_empty()

# methods
func add_card(card: CardResource) -> void:
	if is_full():
		queue_is_full.emit()
		return
	var slot = next_open_slot()
	if slot:
		slot.assign(card)

# handlers
func _on_slot_discard_request(card: CardResource) -> void:
	discard.emit(card)
