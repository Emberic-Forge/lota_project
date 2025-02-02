extends PlayerState


func on_enter(_msg) -> void:
	pass

func on_exit(_msg) -> void:
	pass

func on_update(_delta: float) -> void:

	if not player.is_on_floor() and is_fallling():
		transition_to_state.emit(self, "fall", {})
	elif get_directional_input().length() > 0:
		transition_to_state.emit(self, "move", {})
	elif is_jumping():
		transition_to_state.emit(self, "jump", {})
	elif Input.is_action_pressed("move_crouch"):
		transition_to_state.emit(self, "crouch", {})

func on_physical_update(_delta: float) -> void:
	pass
