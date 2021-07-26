extends KinematicBody2D

var speed = 150
onready var nav = find_parent('World').find_node('Navigation2D')
var path = []
var goal = null setget set_goal

func set_goal(new_goal:Vector2) -> void:
	goal = new_goal
	update_path()

func update_path() -> void:
	path = nav.get_simple_path(position, goal, true)
	find_parent('World').find_node('PathDebugLine').points = path

func _physics_process(delta):
	if path.size() > 0:
		var d = position.distance_to(path[0])
		if d > 2:
			position = (position.linear_interpolate(path[0], (speed * delta)/d))
		else:
			path.remove(0)
