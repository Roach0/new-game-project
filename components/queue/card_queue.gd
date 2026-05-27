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
		slot.discard_request.connect(_on_queue_button_pressed)
	for button in buttons:
		button.pressed.connect(_on_queue_button_pressed.bind(button))
		button.mouse_filter = Control.MOUSE_FILTER_IGNORE


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


# methods - take care, tracking card data in two places here, pull card data here later?
func add_card(card: CardResource) -> void:
	if is_full():
		queue_is_full.emit()
		return
	var next = next_open_slot()
	var slot = next[0]
	var button = next[1]
	if slot:
		slot.assign(card)
		button.mouse_filter = Control.MOUSE_FILTER_STOP
		button.modulate.a = 1.0

func remove_card(button:Button) -> void:
	var b = button.name.lstrip("Button")
	var s = get_node("VBoxContainer/CardQueue/Slot" + b)
	var card = s.card
	discard.emit(card)
	button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	button.modulate.a = 0.0
	s.is_clearing = true
	var tw = s.remove_out()
	tw.tween_callback(func():
		s.clear()
		s.is_clearing = false
		)


# handlers

func _on_queue_button_pressed(button) -> void:
	remove_card(button)
	print(button.name)
