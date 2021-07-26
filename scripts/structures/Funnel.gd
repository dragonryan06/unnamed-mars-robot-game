extends Sprite

var popup = null
var contents = []

func _on_ClickDetector_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if popup == null:
				popup = Globals.StructurePopup.instance()
				popup.initialize(name,contents)
				popup.anchor_bottom = 0.96
				popup.anchor_top = 0.96
				popup.anchor_left = 0.75
				popup.anchor_right = 0.75
				find_parent('World').find_node('HUD').add_child(popup)
			else:
				popup.queue_free()
				popup = null
