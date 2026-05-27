class_name CardQueue
extends MarginContainer

@onready var slots:Array[QueueSlot] = [
	$VBoxContainer/CardQueue/Slot0,
	$VBoxContainer/CardQueue/Slot1,
	$VBoxContainer/CardQueue/Slot2,
	$VBoxContainer/CardQueue/Slot3,
	$VBoxContainer/CardQueue/Slot4]

@onready var button0: Button = $VBoxContainer/ButtonQueue/Button0
@onready var button1: Button = $VBoxContainer/ButtonQueue/Button1
@onready var button2: Button = $VBoxContainer/ButtonQueue/Button2
@onready var button3: Button = $VBoxContainer/ButtonQueue/Button3
@onready var button4: Button = $VBoxContainer/ButtonQueue/Button4

signal queue_is_full
signal discard

func _ready() -> void:
	for slot in slots:
		slot.discard_request.connect(_on_slot_discard_request)

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

# handlers
func _on_slot_discard_request(card: CardResource) -> void:
	discard.emit(card)

func _on_button_0_pressed() -> void:
	print()


func _on_button_1_pressed() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.


func _on_button_4_pressed() -> void:
	pass # Replace with function body.
