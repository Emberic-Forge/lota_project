extends PlayerState

func on_enter(msg) -> void:
	pass

func on_exit() -> void:
	pass

func on_update(_delta: float) -> void:
	if player.is_on_floor():
		var next_state = "move" if get_directional_input().length() > 0 else "idle"
		transition_to_state.emit(self, next_state, {})

func on_physical_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
