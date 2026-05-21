class_name CardQueue
extends HBoxContainer

@onready var slots:Array[QueueSlot] = [$Slot0,$Slot1,$Slot2,$Slot3,$Slot4,$Slot5]

# var card_queue: Array[Card] = []
const MAX_SLOTS = 6
var current_open = slots.filter(func(s): return s.is_empty()).size()

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass

func is_full() -> bool:
	return current_open >= MAX_SLOTS

func update_queue(action:String, card:Card = null, removeSlot:QueueSlot = null):
	if action == "add":
		if is_full():
			print("update queue func: Queue Full")
			return
		var slot = current_open
		if slot:
			slot.assign(card)
		if is_full():
			MissionManager.is_queue_full = true
	if action == "remove":
		removeSlot.clear()
		return

func _on_deck_draw(card:Card) -> void:
	if MissionManager.is_deck_empty:
		print("on deck draw: Deck Empty")
		return
	update_queue("add",card)
