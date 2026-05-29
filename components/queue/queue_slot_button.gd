extends Button


@onready var targetLabel: Label = $VBoxContainer/Target
@onready var triggerLabel: Label = $VBoxContainer/Trigger
@onready var effectLabel: Label = $VBoxContainer/Effect

var target: String
var trigger: String
var effect: String

func _ready() -> void:
	target = targetLabel.text
	trigger = triggerLabel.text
	effect = effectLabel.text
