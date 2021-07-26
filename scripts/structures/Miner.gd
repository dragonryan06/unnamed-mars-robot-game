extends Sprite

onready var ground_tilemap = find_parent('World').find_node('Ground')
var popup = null
var contents = []

func mine() -> void:
	var resources = []
	for x in Globals.structures['miner']['obstruction_size'].x:
		for y in Globals.structures['miner']['obstruction_size'].y:
			var tile = Vector2(x,y)
			var tile_resources = Globals.get_terrain_tile_by_id(ground_tilemap.get_cellv(tile+ground_tilemap.world_to_map(position)))['resources']
			if tile_resources != null:
				for r in tile_resources:
					resources.append(Globals.resources[r])
	for r in resources:
		var stacked = false
		for c in contents:
			if c['type']['name'] == r['name'] and c['count'] < 100:
				c['count'] += 1
				stacked = true
		if stacked == false:
			contents.append({'type':r,'count':1})

func _on_Timer_timeout():
	mine()
	if popup != null:
		popup.update_data(name,contents)

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
