extends CanvasLayer


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		$Inventory.visible = !$Inventory.visible 
	
