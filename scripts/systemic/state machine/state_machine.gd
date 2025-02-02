class_name StateMachine extends Node

@export var initial_state: State

var current_state: State

var states: Dictionary = {}

func initialize():
	for child in get_children():
		if child is State:
			child.transition_to_state.connect(on_child_transition)
			states[child.name.to_lower()] = child

	if initial_state:
		current_state = initial_state
		current_state.on_enter({})
	else:
		print('No initial state found!')

func _process(delta: float) -> void:
	if not current_state:
		return
	current_state.on_update(delta)




func _physics_process(delta: float) -> void:
	if not current_state:
		return
	current_state.on_physical_update(delta)

func on_child_transition(state: State, new_state_name: String, message: Dictionary) -> void:
	if state != current_state:
		print('Invalid state transition')
		return

	var new_state = states[new_state_name.to_lower()]
	if !new_state:
		print('State not found: ', new_state_name)
		return

	if current_state:
		current_state.on_exit(message)

	new_state.on_enter(message)
	current_state = new_state
	print("Transitioned to: ", new_state_name)
