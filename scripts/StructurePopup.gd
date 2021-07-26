extends Panel

func initialize(title:String,contents:Array) -> void:
	update_data(title,contents)

func update_data(title:String,contents:Array) -> void:
	$TitleLabel.text = title
	for l in $ScrollContainer/GridContainer.get_children():
		l.queue_free()
	for content in contents:
		var label = Label.new()
		label.text = str(content['count'])+'x '+content['type']['display_name']
		$ScrollContainer/GridContainer.add_child(label)
