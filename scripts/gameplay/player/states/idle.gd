extends PlayerState


func on_enter(msg) -> void:
	pass

func on_exit() -> void:
	pass

func on_update(_delta: float) -> void:

	if not player.is_on_floor() and is_fallling():
		transition_to_state.emit(self, "fall", {})
	elif get_directional_input().length() > 0:
		transition_to_state.emit(self, "move", {})
	elif is_jumping():
		transition_to_state.emit(self, "jump", {})

func on_physical_update(_delta: float) -> void:
	pass
