class_name CardQueue
extends HBoxContainer

@onready var slots:Array[QueueSlot] = [$Slot0,$Slot1,$Slot2,$Slot3,$Slot4,$Slot5]

signal queue_is_full
signal discard

func _ready() -> void:
	for slot in slots:
		slot.discard_request.connect(_on_slot_discard_request)
func _process(delta: float) -> void:
	pass

# queries
func open_slots() -> Array:
	return slots.filter(func(s): return s.is_empty())
func next_open_slot() -> QueueSlot:
	return open_slots().front()
func is_full() -> bool:
	return open_slots().is_empty()

# methods
func add_card(card: Card) -> void:
	if is_full():
		queue_is_full.emit()
		return
	var slot = next_open_slot()
	if slot:
		slot.assign(card)

# handlers
func _on_slot_discard_request(card: Card) -> void:
	discard.emit(card)
