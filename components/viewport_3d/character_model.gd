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

func set_skin(texture: Texture2D, mesh_surface: int = 0) -> void:
	var mesh_instance := get_node_or_null("MeshInstance3D") as MeshInstance3D
	if mesh_instance == null:
		push_warning("No MeshInstance3D found on model")
		return
	var mat := mesh_instance.get_surface_override_material(mesh_surface)
	if mat == null:
		mat = mesh_instance.get_active_material(mesh_surface).duplicate()
		mesh_instance.set_surface_override_material(mesh_surface, mat)
	if mat is StandardMaterial3D or mat is ORMMaterial3D:
		mat.albedo_texture = texture

func set_mesh(new_mesh: Mesh) -> void:
	var mesh_instance := get_node_or_null("MeshInstance3D") as MeshInstance3D
	if mesh_instance == null:
		return
	mesh_instance.mesh = new_mesh
