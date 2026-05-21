class_name CardQueue
extends HBoxContainer

@onready var slots:Array[QueueSlot] = [$Slot0,$Slot1,$Slot2,$Slot3,$Slot4,$Slot5]

# var card_queue: Array[Card] = []

func current_open():
	return slots.filter(func(s): return s.is_empty()).size()
func current_next():
	return slots.filter(func(s): return s.is_empty()).front()

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass

func is_full() -> bool:
	if current_open() <= 0:
		MissionManager.is_queue_full = true
		return true
	MissionManager.is_queue_full = false
	return false

func update_queue(action:String, card:Card = null, removeSlot:QueueSlot = null):
	if action == "add":
		if is_full():
			return
		var slot = current_next()
		if slot:
			slot.assign(card)
		is_full()
	if action == "remove":
		removeSlot.clear()
		is_full()
		return

func _on_deck_draw(card:Card) -> void:
	if is_full():
		return
	update_queue("add",card)
