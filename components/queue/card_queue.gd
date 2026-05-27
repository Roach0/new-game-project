class_name CardQueue
extends MarginContainer

@onready var slots:Array[QueueSlot] = [
	$VBoxContainer/CardQueue/Slot1,
	$VBoxContainer/CardQueue/Slot2,
	$VBoxContainer/CardQueue/Slot3,
	$VBoxContainer/CardQueue/Slot4,
	$VBoxContainer/CardQueue/Slot5]

@onready var buttons:Array[Button] = [
	$VBoxContainer/ButtonQueue/Button1,
	$VBoxContainer/ButtonQueue/Button2,
	$VBoxContainer/ButtonQueue/Button3,
	$VBoxContainer/ButtonQueue/Button4,
	$VBoxContainer/ButtonQueue/Button5
]
 
signal queue_is_full
signal discard

func _ready() -> void:
	for slot in slots:
		slot.discard_request.connect(_on_slot_discard_request)
	for button in buttons:
		button.pressed.connect(_on_queue_button_pressed.bind(button))

# queries
func open_slots() -> Array:
	return slots.filter(func(s): return s.is_empty())

func next_open_slot() -> Array:
	var next_slot = open_slots().front()
	var next_slot_number = next_slot.name.lstrip("Slot")
	var next_slot_button = get_node("VBoxContainer/ButtonQueue/Button" + next_slot_number)
	return [next_slot, next_slot_button]

func is_full() -> bool:
	return open_slots().is_empty()

# methods
func add_card(card: CardResource) -> void:
	if is_full():
		queue_is_full.emit()
		return
	var slot = next_open_slot()[0]
	var button = next_open_slot()[1]
	if slot:
		slot.assign(card)
		button.modulate.a = 1.0

func remove_card(button:Button) -> void:
	var b = button.name.lstrip("Button")
	var s = get_node("VBoxContainer/CardQueue/Slot" + b)
	button.modulate.a = 0.0
	var tw = s.remove_out()
	tw.tween_callback(s.clear)

# handlers
func _on_slot_discard_request(card: CardResource) -> void:
	discard.emit(card)


func _on_queue_button_pressed(button) -> void:
	remove_card(button)
	print(button.name)
