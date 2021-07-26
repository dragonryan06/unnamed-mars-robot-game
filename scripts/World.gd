extends Node2D

func _ready():
	Worldgen.generate_world($Terrain/Ground, $Terrain/Cliffs, $Terrain/Craters, $Navigation2D/ObstructedTiles)
