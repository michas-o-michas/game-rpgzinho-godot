class_name Inventory_Slot
extends Control

@export var quantity: int = 0
@export var item_texture: Texture2D
@onready var item: TextureRect = $Item
@onready var label = $LabelQuantity

var item_name = ""
var original_item_name = ""
var original_quantity: int
var original_item_texture: Texture2D
var is_dragging = false
var mouse_leave_window = false

func _process(delta):
	if is_dragging and mouse_leave_window:
		_cancel_drag()

func _ready():
	_apply_update()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED	

func _reset():
	quantity = 0
	original_quantity = 0
	item_texture = null
	original_item_texture = null
	is_dragging = false
	mouse_leave_window = false
	item_name = ""
	original_item_name = ""

func _apply_update():
	item.texture = item_texture
	label.text = str(quantity) if quantity > 0 else ""
	tooltip_text = item_name

func _can_drop_data(at_position, data):
	return data["item"] is Inventory_Slot and data["item"].item_texture != null

func _get_drag_data(at_position):
	is_dragging = true
	original_quantity = quantity
	original_item_texture = item_texture
	var preview = self.duplicate()
	preview.get_node("Background").hide()
	preview.get_node("LabelQuantity").hide()
	preview.get_node("Item").scale = Vector2(1.1, 1.1)
	preview.get_node("Item").position -= preview.size / 2

	var data = {
		"item": preview,
		"backup": self
	}

	set_drag_preview(preview)
	_clear_slot()
	return data

func _clear_slot():
	item_texture = null
	quantity = 0
	_apply_update()

func _drop_data(at_position, data):
	if data.has("item") and data.item is Inventory_Slot:
		if name == data.item.name:
			data.backup._cancel_drag()
		if data["backup"].is_dragging == false: return 
		if quantity > 0:
			# juntar items
			if data.item.item_texture == item_texture:
				data.item.quantity += quantity
			else:
				data["backup"].quantity = quantity
				data["backup"].item_texture = item_texture
				data["backup"].item_name = item_name
			data["backup"]._apply_update()
		quantity = data.item.quantity
		item_texture = data.item.item_texture
		item_name = data.item.item_name
		data["backup"]._reset()
		data.item.is_dragging = false
		_apply_update()
	else:
		data["backup"]._apply_update()
		data["backup"].is_dragging = false

func _cancel_drag():
	quantity = original_quantity
	item_texture = original_item_texture
	item_name = original_item_name
	is_dragging = false
	_apply_update()

func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_ENTER:
		mouse_leave_window = false
	elif what == NOTIFICATION_WM_MOUSE_EXIT:
		mouse_leave_window = true
