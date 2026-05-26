extends AspectRatioContainer
class_name QueueSlot


@onready var title = $BG/Title
@onready var description = $BG/Description
@export var drop_offset: Vector2 = Vector2(0, -300)
@export var duration: float  = 0.55
var card: CardResource = null
var _rest_pos: Vector2
var _layout_ready := false

signal discard_request(card: CardResource)

func _ready() -> void:
	clear()
	# wait one frame so the parent container finishes its layout pass
	await get_tree().process_frame
	_rest_pos = position
	position = _rest_pos + drop_offset
	drop_in()

func drop_in() -> void:
	var tw: Tween = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_BOUNCE)
	tw.tween_property(
		self,
		"position",
		_rest_pos,
		duration
	)

# queries
func is_empty() -> bool:
	return card == null

# methods
func assign(data: CardResource) -> void:
	if data == null:
		return
	card = data
	title.text = data.card_name
	description.text = data.description

func clear() -> void:
	card = null
	$Layout/Title.text = ""
	$Layout/Description.text = ""

# handlers
func _on_button_pressed() -> void:
	if card == null:
		return
	discard_request.emit(card)
	clear()
