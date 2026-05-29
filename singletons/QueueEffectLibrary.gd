extends Node

signal effect_requested(effect: EffectData, target: Node)
signal effect_queued(effect: EffectData)

func _ready() -> void:
	effect_requested.connect(_on_effect_requested)
	effect_queued.connect(_on_effect_queued)

func _on_effect_requested(effect: EffectData, target: Node) -> void:
	if target.has_method("receive_effect"):
		target.receive_effect(effect)

func _on_effect_queued(effect: EffectData) -> void:
	effect_queue.append(effect)
