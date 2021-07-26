extends Node2D

onready var obstruction_tilemap = find_parent('World').find_node('ObstructedTiles')
const selected_tile_texture = preload('res://assets/selected_tile_image.png')

const acceleration = 0.5
const max_speed = 20
const max_zoom = Vector2(50,50)
var speed = 0
onready var placing = null setget set_placing
var placing_type = null
var selected_tile

func _ready():
	set_placing(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func set_placing(new_value):
	placing = new_value
	if placing == false:
		selected_tile = Sprite.new()
		selected_tile.texture = selected_tile_texture
		selected_tile.centered = false
		selected_tile.global_position = Vector2(stepify(get_global_mouse_position().x,64),stepify(get_global_mouse_position().y,64))
		selected_tile.z_index = 1
		add_child(selected_tile)
	else:
		selected_tile.queue_free()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if $Camera2D.zoom - Vector2(1,1) != Vector2(0,0):
				$Camera2D.zoom -= Vector2(1,1)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if $Camera2D.zoom + Vector2(1,1) != max_zoom:
				$Camera2D.zoom += Vector2(1,1)

func _process(_delta):
	if Input.is_action_pressed('ui_right'):
		if speed < max_speed:
			speed += acceleration
		position.x += speed
	if Input.is_action_pressed('ui_left'):
		if speed < max_speed:
			speed += acceleration
		position.x -= speed
	if Input.is_action_pressed('ui_up'):
		if speed < max_speed:
			speed += acceleration
		position.y -= speed
	if Input.is_action_pressed('ui_down'):
		if speed < max_speed:
			speed += acceleration
		position.y += speed
	if speed > 0:
		speed -= 0.25
	if placing == true:
		$placement.global_position = Vector2(stepify(get_global_mouse_position().x,64),stepify(get_global_mouse_position().y,64))
		$placement.modulate = Color(255,0,0)
		var obstructed = false
		for x in placing_type['obstruction_size'].x:
			for y in placing_type['obstruction_size'].y:
				if obstruction_tilemap.get_cell(obstruction_tilemap.world_to_map($placement.global_position).x+x,obstruction_tilemap.world_to_map($placement.global_position).y+y) != 0:
					obstructed = true
					break
		if not obstructed:
			$placement.modulate = Color(0,255,0)
			if Input.is_action_just_pressed('ui_rotate_placement'):
				if placing_type['tags'].has(Globals.structure_tags.is_rotatable):
					$placement.rotation_degrees += 90
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				var structure = placing_type['scene'].instance()
				structure.global_position = $placement.global_position
				structure.rotation = $placement.rotation
				find_parent('World').get_node('Structures').add_child(structure)
				for x in placing_type['obstruction_size'].x:
					for y in placing_type['obstruction_size'].y:
						obstruction_tilemap.set_cell(obstruction_tilemap.world_to_map(structure.global_position).x+x,obstruction_tilemap.world_to_map(structure.global_position).y+y,1)
				$placement.queue_free()
				set_placing(false)
				placing_type = null
	else:
		if is_instance_valid(selected_tile):
			selected_tile.global_position = Vector2(stepify(get_global_mouse_position().x,64)-64,stepify(get_global_mouse_position().y,64)-64)
