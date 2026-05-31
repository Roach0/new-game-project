extends Button
class_name QueueSlotButton

@onready var targetLabel: Label = $VBoxContainer/Target
@onready var triggerLabel: Label = $VBoxContainer/Trigger
@onready var effectLabel: Label = $VBoxContainer/Effect

func update(tar: String, tri: String, eff: String) -> void:
	targetLabel.text = tar
	triggerLabel.text = tri
	effectLabel.text = eff
