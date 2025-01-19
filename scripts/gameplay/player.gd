class_name Player extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_height: float = 4.5
@export_range(1, 100, 0.1) var sensitivity : float;

@onready var cam_anchor = $cam_anchor
@onready var interaction_popup = $hud/interaction_popup


var current_interactable : InteractionArea3D

# Called when the node enters the scene tree for the first time.
func _ready():
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

func calculate_jump_velocity() -> float:
	# Using the formula v = sqrt(2 * g * h)
	# where v is the jump velocity, g is the gravity, and h is the jump height
	return sqrt(2 * abs(get_gravity().y) * jump_height)

func handle_interactions() -> void:
	if !current_interactable:
		return
	if not Input.is_action_just_pressed("interact"):
		return

	current_interactable.on_interact.emit(self,current_interactable)

func _process(_delta : float) -> void:
	# TODO: Move this logic to its own node.
	handle_interactions()

func _physics_process(delta : float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = calculate_jump_velocity()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
