extends Panel

onready var Name = $ScrollContainer/GridContainer/Name
onready var Description = $ScrollContainer/GridContainer/Description

func update_data(new_tile):
	Name.text = 'Name: ' + new_tile['display_name']
	Description.text = 'Description: ' + new_tile['description']
