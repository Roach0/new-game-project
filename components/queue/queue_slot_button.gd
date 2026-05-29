extends Button

@onready var targetLabel: Label = $VBoxContainer/Target
@onready var triggerLabel: Label = $VBoxContainer/Trigger
@onready var effectLabel: Label = $VBoxContainer/Effect

var target: String = "":
	set(value): target = value; targetLabel.text = value

var trigger: String = "":
	set(value): trigger = value; triggerLabel.text = value

var effect: String = "":
	set(value): effect = value; effectLabel.text = value

func update(tar: String, tri: String, eff: String) -> void:
	target = tar
	trigger = tri
	effect = eff
