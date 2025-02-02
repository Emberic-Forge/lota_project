extends Node
@export_range(1, 100, 0.1) var sensitivity: float;

var player : Player
var cam_anchor
var current_mode

func initialize(player_node : Player) -> void:
	player = player_node
	cam_anchor = player.get_node("cam_anchor")
	current_mode = Input.MOUSE_MODE_CAPTURED
	Input.set_mouse_mode(current_mode)
	print("Camera Controller initialized")


func get_percentage_of_sensitivity() -> float:
	return sensitivity / 100.0;

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion && current_mode == Input.MOUSE_MODE_CAPTURED:
		player.rotate_y(deg_to_rad(-event.relative.x * get_percentage_of_sensitivity()))
		cam_anchor.rotate_x(deg_to_rad(-event.relative.y * get_percentage_of_sensitivity()))
		cam_anchor.rotation_degrees.x = clamp(cam_anchor.rotation_degrees.x, -90, 90)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		current_mode = toggle_mode()
		Input.set_mouse_mode(current_mode)
		print("Mouse mode: ", current_mode)

func toggle_mode() -> int:
	if current_mode == Input.MOUSE_MODE_CAPTURED:
		current_mode = Input.MOUSE_MODE_VISIBLE
	else:
		current_mode = Input.MOUSE_MODE_CAPTURED

	return current_mode
