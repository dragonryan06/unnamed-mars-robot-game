extends Node

var tile_noise
var ore_noise

func generate_world(ground_tilemap, cliff_tilemap, crater_tilemap, obstruction_tilemap) -> void:
	randomize()
	tile_noise = OpenSimplexNoise.new()
	tile_noise.seed = randi()
	tile_noise.octaves = 3
	tile_noise.period = 100
	tile_noise.lacunarity = 1.5
	tile_noise.persistence = 0.75
	ore_noise = OpenSimplexNoise.new()
	ore_noise.seed = randi()
	ore_noise.octaves = 2
	ore_noise.period = 100
	ore_noise.lacunarity = 1.5
	ore_noise.persistence = 0.75
	place_ground(ground_tilemap, obstruction_tilemap)
	place_cliffs(cliff_tilemap, obstruction_tilemap)
	place_ore(ground_tilemap)
	obstruction_tilemap.update_dirty_quadrants()

func place_ground(ground_tilemap, obstruction_tilemap) -> void:
	for x in Globals.worldsize.x:
		for y in Globals.worldsize.y:
			ground_tilemap.set_cell(x-(Globals.worldsize.x/2),y-(Globals.worldsize.y/2),Globals.terrain_tiles['regolith']['id'])
			obstruction_tilemap.set_cell(x-(Globals.worldsize.x/2),y-(Globals.worldsize.y/2),0)

func place_cliffs(cliff_tilemap, obstruction_tilemap) -> void:
	for x in Globals.worldsize.x:
		for y in Globals.worldsize.y:
			if tile_noise.get_noise_2d(x,y) > 0.25:
				cliff_tilemap.set_cell(x-(Globals.worldsize.x/2),y-(Globals.worldsize.y/2),0)
				obstruction_tilemap.set_cell(x-(Globals.worldsize.x/2),y-(Globals.worldsize.y/2),1)

func place_ore(ground_tilemap) -> void:
	for x in Globals.worldsize.x:
		for y in Globals.worldsize.y:
			if ore_noise.get_noise_2d(x,y) > 0.5:
				ground_tilemap.set_cell(x-(Globals.worldsize.x/2),y-(Globals.worldsize.y/2),Globals.terrain_tiles['hematite_ore']['id'])
