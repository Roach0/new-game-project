extends AspectRatioContainer
class_name QueueSlot

@onready var icon_rect = $Layout/BG

@export var drop_offset: Vector2 = Vector2(0, -300)
@export var duration: float = 0.55

var card: CardResource = null
var _rest_pos: Vector2

signal discard_request(card: CardResource)

func _ready() -> void:
	clear()
	drop_in()  # no more _rest_pos needed

func drop_in() -> void:
	icon_rect.position.y = drop_offset.y  # start offset
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_BOUNCE)
	tw.tween_property(icon_rect, "position", Vector2.ZERO, duration)

func is_empty() -> bool:
	return card == null

func assign(data: CardResource) -> void:
	if data == null:
		return
	card = data
	drop_in()
	_apply_icon(data.icon)

func clear() -> void:
	card = null
	# if title: title.text = ""
	# if description: description.text = ""
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
