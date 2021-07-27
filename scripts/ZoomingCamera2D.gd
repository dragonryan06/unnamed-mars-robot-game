extends Camera2D

var min_zoom := 0.25
var max_zoom := 10
var zoom_factor := 0.25
var zoom_duration := 0.2
var move_speed := 8

var _zoom_level := 1.0 setget _set_zoom_level

var velocity := Vector2(0,0)

onready var tween = $Tween

func _set_zoom_level(value: float) -> void:
	_zoom_level = clamp(value, min_zoom, max_zoom)
	tween.interpolate_property(self,'zoom',zoom,Vector2(_zoom_level, _zoom_level),zoom_duration,tween.TRANS_SINE,tween.EASE_OUT)
	tween.start()

func _unhandled_input(event):
	if event.is_action_pressed('zoom_in'):
		_set_zoom_level(_zoom_level - zoom_factor)
		move_speed -= 1
	if event.is_action_pressed('zoom_out'):
		_set_zoom_level(_zoom_level + zoom_factor)
		move_speed += 1

func _physics_process(delta):
	if Input.is_action_pressed('ui_up'):
		velocity.y -= move_speed
	if Input.is_action_pressed('ui_down'):
		velocity.y += move_speed
	if Input.is_action_pressed('ui_left'):
		velocity.x -= move_speed
	if Input.is_action_pressed('ui_right'):
		velocity.x += move_speed
	position += velocity * delta
	if velocity.x > 0:
		velocity.x -= 0.5*move_speed
	elif velocity.x < 0:
		velocity.x += 0.5*move_speed
	if velocity.y > 0:
		velocity.y -= 0.5*move_speed
	elif velocity.y < 0:
		velocity.y += 0.5*move_speed
