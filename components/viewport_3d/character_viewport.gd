extends SubViewportContainer

signal animation_finished(anim_name: StringName)

@export var idle_animation: StringName = &"Idle"

@onready var model: Node = $SubViewport/CharacterModel

func _ready() -> void:
	if model.has_method("play_anim"):
		model.call("play_anim", idle_animation)
	elif model.has_method("play_default_idle"):
		model.call("play_default_idle")

	var model_anim_player := model.get_node_or_null("AnimationPlayer") as AnimationPlayer
	if model_anim_player != null:
		model_anim_player.animation_finished.connect(_on_model_animation_finished)

func play_anim(anim_name: StringName) -> void:
	if model.has_method("play_anim"):
		model.call("play_anim", anim_name)

func _on_model_animation_finished(anim_name: StringName) -> void:
	animation_finished.emit(anim_name)
