extends AspectRatioContainer
class_name QueueSlot

@onready var title = $Layout/Title
@onready var description = $Panel/Description
@onready var icon_rect = $Layout/AspectRatioContainer/BG  # add TextureRect here

@export var drop_offset: Vector2 = Vector2(0, -300)
@export var duration: float = 0.55

var card: CardResource = null
var _rest_pos: Vector2

signal discard_request(card: CardResource)

func _ready() -> void:
	clear()
	await get_tree().process_frame
	_rest_pos = position
	position = _rest_pos + drop_offset
	drop_in()

func drop_in() -> void:
	position = _rest_pos + drop_offset 
	var tw: Tween = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_BOUNCE)
	tw.tween_property(self, "position", _rest_pos, duration)

func is_empty() -> bool:
	return card == null

func assign(data: CardResource) -> void:
	if data == null:
		return
	card = data
	title.text = data.card_name
	description.text = data.description
	drop_in()
	_apply_icon(data.icon)

func clear() -> void:
	card = null
	if title: title.text = ""
	if description: description.text = ""
	if icon_rect: icon_rect.modulate.a = 0.0

func _apply_icon(texture: Texture2D) -> void:
	icon_rect.texture = texture
	icon_rect.modulate.a = 1.0

# handlers
func _on_button_pressed() -> void:
	if card == null:
		return
	discard_request.emit(card)
	clear()
