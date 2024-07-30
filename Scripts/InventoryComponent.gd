class_name Inventory_Component extends Node

@export var max_items = 5
var items: Array = [
	{
		"itemName":"ai",
		"quantity":1,
		"texture":preload("res://Assets/Player/player (3).png")
	}
]

func _add_item(item_quantity:int, name:String, texture:Resource ) -> bool:
	if items.size() < max_items:
		items.append({
			"itemName": name,
			"item_quantity":item_quantity,
			"texture":texture
		})
		return true
	return false

