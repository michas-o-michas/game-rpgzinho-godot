extends Control

@onready var grid_container = $Panel/CenterContainer/GridContainer

@export var max_slots = 24



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _add_item(item_quantity:int, name:String, texture:Resource ):
	var slot = _get_fist_empty_slot()
	slot.quantity = item_quantity
	slot.item_texture = texture
	slot._apply_update()

func _get_fist_empty_slot():
	for ui_item in grid_container.get_children():
		if ui_item.quantity == 0:
			return ui_item
