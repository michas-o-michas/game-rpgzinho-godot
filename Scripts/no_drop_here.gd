extends Panel

func _can_drop_data(at_position, data):
	return  true

func _drop_data(at_position, data):
	data['backup'].quantity = data['item'].quantity
	data['backup'].item_texture = data['item'].item_texture
	data['backup'].original_item_name =  data['item'].item_name
	data['backup']._apply_update()
