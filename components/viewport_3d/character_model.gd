extends Node3D

const DEFAULT_IDLE_ANIM: StringName = &"Idle"

@onready var anim: AnimationPlayer = $AnimationPlayer

func play_anim(anim_name: StringName) -> void:
	if anim == null:
		return
	if not anim.has_animation(anim_name):
		push_warning("Animation not found: %s" % String(anim_name))
		return
	if anim.current_animation != String(anim_name):
		anim.play(anim_name)

func play_default_idle() -> void:
	if anim == null:
		return
	if anim.has_animation(DEFAULT_IDLE_ANIM):
		play_anim(DEFAULT_IDLE_ANIM)
		return

	var list := anim.get_animation_list()
	if list.size() > 0:
		# Fallback so you still get motion if "Idle" has a different name in the GLB.
		play_anim(StringName(list[0]))
