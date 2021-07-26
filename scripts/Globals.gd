extends Node

const StructurePopup = preload('res://scenes/StructurePopup.tscn')

const worldsize = Vector2(500,500)

enum structure_tags {
	is_rotatable
}

const structures = {
	'miner':{
		'name':'miner',
		'display_name':'Miner',
		'description':'Pulls resources from the ground beneath it',
		'texture':preload('res://assets/miner.png'),
		'obstruction_size':Vector2(2,2),
		'scene':preload('res://scenes/structures/Miner.tscn'),
		'tags':[]
	},
	'smelter':{
		'name':'smelter',
		'display_name':'Smelter',
		'description':'Turns raw ores into refined materials', # later replace this with a liquid metal casting system or something, it melts to liquid tehn casts into ingots
		'texture':preload('res://assets/smelter.png'),
		'obstruction_size':Vector2(2,2),
		'scene':preload('res://scenes/structures/Smelter.tscn'),
		'tags':[]
	},
	'depot':{
		'name':'depot',
		'display_name':'Depot',
		'description':'An access point for droids, items can be picked up or placed down here',
		'texture':preload('res://assets/depot.png'),
		'obstruction_size':Vector2(1,1),
		'scene':preload('res://scenes/structures/Depot.tscn'),
		'tags':[]
	},
	'funnel':{
		'name':'funnel',
		'display_name':'Funnel',
		'description':'Transports items from one structure to another', # this could alternatively be replaced with a robotic arm sort of thing like in factorio
		'texture':preload('res://assets/funnel.png'),
		'obstruction_size':Vector2(1,1),
		'scene':preload('res://scenes/structures/Funnel.tscn'),
		'tags':[structure_tags.is_rotatable]
	}
}
const terrain_tiles = {
	'regolith':{
		'name':'regolith',
		'display_name':'Regolith',
		'description':'The heterogenous mixture of rocks and soil that coats the surface of terrestrial planets. High quantities of iron oxide give Martian regolith its famous red color',
		'id':0,
		'resources':null
	},
	'hematite_ore':{
		'name':'hematite_ore',
		'display_name':'Hematite Ore',
		'description':'Hematite, also known as iron ore, is found all over the martian landscape alongside iron oxide (rust), hence the nickname The Red Planet',
		'id':1,
		'resources':['hematite']
	}
}
const resources = {
	'hematite':{
		'name':'hematite',
		'display_name':'Hematite',
		'description':'Fe2O3, Iron Ore'
	}
}

func get_terrain_tile_by_id(id:int):
	for tile in terrain_tiles.values():
		if tile['id'] == id:
			return tile
	return str(id) + ' is not a valid id, something went wrong'
