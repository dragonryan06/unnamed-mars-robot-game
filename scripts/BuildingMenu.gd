extends Panel

onready var menu_buttons = $ScrollContainer/GridContainer.get_children()
var placing = false

func _ready():
	for button in menu_buttons:
		button.connect('pressed',self,'_on_menu_button_pressed',[button])

func _on_menu_button_pressed(button):
	var placement = Sprite.new()
	placement.position = Vector2(0,0)
	placement.name = 'placement'
	placement.centered = false
	placement.texture = Globals.structures[button.name]['texture']
	placement.z_index = 2
	find_parent('Player').add_child(placement)
	find_parent('Player').placing = true
	find_parent('Player').placing_type = Globals.structures[button.name]

func _on_BuildingMenu_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_BuildingMenu_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
