class_name Player extends CharacterBody3D

@export_range(1, 100, 0.1) var sensitivity: float;

@onready var cam_anchor = $cam_anchor
@onready var interaction_popup = $hud/interaction_popup
@onready var state_machine = $state_machine

var current_interactable: InteractionArea3D


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.initialize()

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# TODO: Move this logic to another node instead.
	interaction_popup.text = ''
	pass

func get_percentage_of_sensitivity() -> float:
	return sensitivity / 100.0;

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * get_percentage_of_sensitivity()))
		cam_anchor.rotate_x(deg_to_rad(-event.relative.y * get_percentage_of_sensitivity()))
		cam_anchor.rotation_degrees.x = clamp(cam_anchor.rotation_degrees.x, -90, 90)

func handle_interactions() -> void:
	if !current_interactable:
		return
	if not Input.is_action_just_pressed("interact"):
		return
	current_interactable.on_interact.emit(self, current_interactable)

func _process(_delta: float) -> void:
	# TODO: Move this logic to its own node.
	handle_interactions()
