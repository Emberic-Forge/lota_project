class_name Player extends CharacterBody3D

@onready var health_manager = $health_manager
@onready var camera_controller = $camera_controller
@onready var interaction_popup = $hud/interaction_popup
@onready var state_machine = $state_machine

var current_interactable: InteractionArea3D
var currentMode


# Called when the node enters the scene tree for the first time.
func _ready():
	camera_controller.initialize(self)
	state_machine.initialize()

	# TODO: Move this logic to another node instead.
	interaction_popup.text = ''
	pass

func handle_interactions() -> void:
	if !current_interactable:
		return
	if not Input.is_action_just_pressed("interact"):
		return
	current_interactable.on_interact.emit(self, current_interactable)

func _process(_delta: float) -> void:
	# TODO: Move this logic to its own node.
	handle_interactions()
