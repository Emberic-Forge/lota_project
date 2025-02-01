extends Node
@export_range(1, 100, 0.1) var sensitivity: float;



var player : Player
var cam_anchor
var current_mode

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_percentage_of_sensitivity() -> float:
	return sensitivity / 100.0;

func _unhandled_input(event) -> void:
	if !cam_anchor:
		cam_anchor = player.get_node("cam_anchor")

	if event is InputEventMouseMotion:
		player.rotate_y(deg_to_rad(-event.relative.x * get_percentage_of_sensitivity()))
		cam_anchor.rotate_x(deg_to_rad(-event.relative.y * get_percentage_of_sensitivity()))
		cam_anchor.rotation_degrees.x = clamp(cam_anchor.rotation_degrees.x, -90, 90)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		current_mode = Input.MOUSE_MODE_CAPTURED if current_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_VISIBLE
		Input.set_mouse_mode(current_mode)
