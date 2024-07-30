extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var ui_inventory:Node = $UI_Inventoy/Inventory
@export var inventory:Inventory_Component

func _physics_process(delta):
	var direction = Input.get_vector("a", "d", "w", "s")
	velocity = direction * SPEED
	move_and_slide()

func _on_colliision_area_component_area_entered(area:Area2D):
	if area.is_in_group("drop"):
		var obj = {
			"texture":area.texture,
			"itemName":area.itemName,
			"quantity":area.quantity
		}
		var has_add =  inventory._add_item(obj.quantity,obj.itemName, obj.texture )
		if has_add:
			area.queue_free()
			ui_inventory._add_item(obj.quantity,obj.itemName, obj.texture )
			
